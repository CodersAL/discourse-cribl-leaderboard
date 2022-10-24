import Controller from '@ember/controller';
import { action } from '@ember/object';
import discourseComputed from 'discourse-common/utils/decorators';
import Leaderboard from '../models/cribl-leaderboard';

export default Controller.extend({
  queryParams: {
    period: 'period',
    page: 'page',
  },
  isLoading: false,
  isLoadingMore: false,

  @discourseComputed('page', 'period')
  hasParams(page, period) {
    if(period == null)
      this.set('period', 'quarter');
    return true;
  },

  @action
  loadMore() {
    const leaderboard = this.get('leaderboard');
    const limit = this.get('leaderboardRowLimit');
    const canLoadMore = leaderboard.length < limit;

    if (canLoadMore && !this.isLoadingMore) {
      this.set('isLoadingMore', true);
      Leaderboard.loadMore(this.loadMoreUrl).then((result) => {
        leaderboard.addObjects(result.data.props);
        this.set('loadMoreUrl', result.meta.load_more_leaderboard || null);
        this.set('isLoadingMore', false);
      });
    }
  },
});
