import Nav from './Nav';
const { Route } = ReactRouter;
import Album from './View/Albums/Album';
import Albums from './View/Albums';
import Songs from './View/Songs';
import Artists from './View/Artists';
import Playlists from './View/Playlists';
import Search from './View/Search';

const withNav = Component => props => (
	<div>
		<Nav {...props} />
		<Component {...props} />
	</div>
);

export default () => (
	<div className="main">
		<Route path="/browse/albums/:albumId" component={Album} />
		<Route exact path="/browse/albums" component={withNav(Albums)} />
		<Route exact path="/browse/artists" component={withNav(Artists)} />
		<Route exact path="/browse/playlists" component={withNav(Playlists)} />
		<Route exact path="/browse/search" component={Search} />
		<Route exact path="/browse" component={withNav(Songs)} />
	</div>
);
