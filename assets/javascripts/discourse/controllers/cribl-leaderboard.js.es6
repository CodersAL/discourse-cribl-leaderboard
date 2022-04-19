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

  @discourseComputed('loadMoreUrl')
  canLoadMore(loadMoreUrl) {
    return loadMoreUrl === null ? false : true;
  },

  @discourseComputed('page', 'period')
  hasParams(page, period) {
    if (page && period) {
      return true;
    } else {
      return false;
    }
  },

  @action
  loadMore() {
    if (this.canLoadMore && !this.isLoadingMore) {
      this.set('isLoadingMore', true);
      console.log('this', this);
      Leaderboard.loadMore(this.loadMoreUrl).then((result) => {
        this.setProperties({
          leaderboard: result.data.props,
          loadMoreUrl: result.meta.load_more_leaderboard || null,
          isLoadingMore: false,
        });
      });
    }
  },
});
