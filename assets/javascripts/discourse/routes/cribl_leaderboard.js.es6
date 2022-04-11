import DiscourseRoute from 'discourse/routes/discourse';

export default DiscourseRoute.extend({
  model() {
    // return ajax('/cribl_leaderboard/todays.json');
    return [
      {
        id: '0',
        name: 'John Doe',
        rank: '1',
        points: '500',
      },
    ];
  },
});
