// import { ajax } from 'discourse/lib/ajax';

export default {
  shouldRender(args, component) {
    return component.siteSettings.cribl_leaderboard_enabled;
  },

  setupComponent(args, component) {
    this.set('classNames', ['linked-stat']);

    // ajax(`/cribl_leaderboard/todays/${args.user.username}.json`).then(
    //   ({ request_data }) => {
    //     const points = request_data[0].todays_points;
    //     component.set('points', points);
    //   }
    // );
  },
};
