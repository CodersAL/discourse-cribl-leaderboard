export default function () {
  this.route('cribl', { path: '/cribl' }, function () {
    this.route('leaderboard');
  });
}
