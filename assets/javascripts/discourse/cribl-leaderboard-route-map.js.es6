export default function () {
  this.route('cribl_leaderboard', { path: '/cribl_leaderboard' }, function () {
    this.route('todays');
    this.route('quarters');
    this.route('custom');
  });
}
