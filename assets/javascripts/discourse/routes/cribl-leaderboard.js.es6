import DiscourseRoute from 'discourse/routes/discourse';
import I18n from 'I18n';
import Leaderboard from '../models/cribl-leaderboard';

export default DiscourseRoute.extend({
  queryParams: {
    period: { refreshModel: true },
    page: { refreshModel: true },
  },

  model(params) {
    console.log('model', params);
    this.controllerFor('cribl.leaderboard').set('isLoading', true);
    return Leaderboard.list(params).then((result) => {
      this.controllerFor('cribl.leaderboard').set('isLoading', false);
      return result;
    });
  },

  titleToken() {
    return I18n.t('cribl_leaderboard.title');
  },

  setupController(controller, model) {
    controller.setProperties({
      leaderboard: model.data.props,
      loadMoreUrl: model.meta.load_more_leaderboard,
      leaderboardRowLimit: model.meta.total_rows_leaderboard,
    });
  },
});
