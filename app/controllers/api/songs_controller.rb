require 'open-uri'
require 'rest-client'

class Api::SongsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    query = params[:query]
    @songs = Song.all.limit(60).with_audio.with_artist.with_album
    render :index
  end

  def create
    node_endpoint = "http://localhost:3001"
    rails_endpoint = "http://localhost:3000/api/receive_song_file"
    res = RestClient.get("#{node_endpoint}?url=https://www.youtube.com/watch?v=#{song_params[:video_id]}&title=#{song_params[:title]}&album_id=#{song_params[:album_id]}&callback=#{rails_endpoint}")
    audio_id = JSON.parse(res.body)["id"]
    render json: { waitingFor: audio_id }
  end

  def receive_song_file
    filename = params[:filename]
    album_id = params[:album_id]
    title = params[:title]
    node_endpoint = "http://localhost:3001"
    file = open("#{node_endpoint}/songs/#{filename}")
    @song = Song.new(
      title: title, 
      album_id: album_id, 
      audio: { io: file, filename: "#{filename}.webm"}
    )
    if @song.save
      render :show
    else
      render json: @song.errors.full_messages, status: 422
    end
  end

  def song_params
    params.require(:song).permit(:video_id, :title, :album_id)
  end
end