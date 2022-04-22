import { apiInitializer } from 'discourse/lib/api';

export default apiInitializer('0.11.1', (api) => {
  const siteSettings = api.container.lookup('site-settings:main');
  const currentUser = api.getCurrentUser();

  if (!siteSettings.cribl_leaderboard_enabled) {
    return;
  }

  if (siteSettings.cribl_hamburger_leaderboard_button && currentUser) {
    api.decorateWidget('hamburger-menu:generalLinks', () => {
      return {
        route: 'cribl.leaderboard',
        label: 'cribl_leaderboard.title',
        className: 'cribl-leaderboard-link',
      };
    });
  }

  if (siteSettings.cribl_nav_leaderboard_button && currentUser) {
    api.addNavigationBarItem({
      name: 'cribl.leaderboard',
      displayName: I18n.t('cribl_leaderboard.title'),
      href: '/cribl/leaderboard',
    });
  }
});
