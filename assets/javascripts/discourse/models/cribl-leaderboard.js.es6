import EmberObject from '@ember/object';
import { ajax } from 'discourse/lib/ajax';
import User from 'discourse/models/user';

const Leaderboard = EmberObject.extend({});

Leaderboard.reopenClass({
  list(params) {
    let filters = [];

    if (params.period) {
      filters.push(`period=${params.period}`);
    }

    if (params.page) {
      filters.push(`page=${params.page}`);
    }

    return ajax(`/cribl/leaderboard.json?${filters.join('&')}`).then(
      (result) => {
        return this.buildLeaderboardData(result);
      }
    );
  },

  loadMore(loadMoreUrl) {
    return ajax(loadMoreUrl).then((result) => {
      if (!result) {
        return;
      }
      return this.buildLeaderboardData(result);
    });
  },

  buildLeaderboardData(result) {
    if (!result.data || result.data === null) {
      return;
    }
    const { data, meta } = result;
    const currentUser = User.current() ? User.current() : null;
    const props = data.map((item) => {
      return {
        id: item.id,
        active: item.active,
        user: {
          username: item.username,
          name: item.name,
          avatar_template: item.avatar_template.replace('{size}', '75'),
          path: `/u/${item.username}`,
        },
        rank: item.mrank,
        yesterdayRank: item.yesterdays_rank,
        dailyRankMove: item.daily_rank_move,
        timestamp: item.timestamp,
        points: item.points,
        currentUser: item.username === currentUser?.username ? true : false,
      };
    });

    data.props = props;
    return result;
  },
});

export default Leaderboard;
