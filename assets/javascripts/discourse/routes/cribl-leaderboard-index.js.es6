import DiscourseRoute from 'discourse/routes/discourse';

export default DiscourseRoute.extend({
  beforeModel(transition) {
    this.transitionTo('cribl_leaderboard.todays');
  },
});
