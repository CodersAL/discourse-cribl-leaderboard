import EmberObject from '@ember/object';
import { ajax } from 'discourse/lib/ajax';

const Leaderboard = EmberObject.extend({});

Leaderboard.reopenClass({
  buildLeaderboardData(type, user) {
    return ajax(`/cribl_leaderboard/${type}.json`).then((data) => {
      const { request_data } = data;

      const props = request_data.map((item) => {
        return {
          id: item.id,
          type,
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
          points: item.todays_points || item.quarter_points || item.points,
          currentUser: item.username === user.username ? true : false,
        };
      });

      data.props = props;
      return data.props;
    });
  },
});

export default Leaderboard;
