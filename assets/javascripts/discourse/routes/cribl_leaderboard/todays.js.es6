import DiscourseRoute from 'discourse/routes/discourse';

export default DiscourseRoute.extend({
  model() {
    return ajax('/cribl_leaderboard/todays.json');
  },
});
