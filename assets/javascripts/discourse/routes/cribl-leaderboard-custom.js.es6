import DiscourseRoute from 'discourse/routes/discourse';
import Leaderboard from '../models/cribl-leaderboard';

export default DiscourseRoute.extend({
  model() {
    return Leaderboard.buildLeaderboardData('custom', this.currentUser);
  },

  setupController(controller, model) {
    controller.setProperties({ leaderboard: model, leaderboardType: 'custom' });
  },
});
