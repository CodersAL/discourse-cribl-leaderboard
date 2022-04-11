import { apiInitializer } from 'discourse/lib/api';

export default apiInitializer('0.11.1', (api) => {
  const siteSettings = api.container.lookup('site-settings:main');

  if (!siteSettings.cribl_leaderboard_enabled) {
    return;
  }

  if (siteSettings.cribl_hamburger_leaderboard_button) {
    api.decorateWidget('hamburger-menu:generalLinks', () => {
      return {
        route: 'cribl_leaderboard',
        label: 'cribl_leaderboard.title',
        className: 'cribl-leaderboard-link',
      };
    });
  }

  if (siteSettings.cribl_nav_leaderboard_button) {
    api.addNavigationBarItem({
      name: 'cribl_leaderboard',
      displayName: I18n.t('cribl_leaderboard.title'),
      href: '/cribl_leaderboard',
    });
  }
});
