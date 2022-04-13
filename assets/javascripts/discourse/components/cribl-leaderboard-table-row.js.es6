import Component from '@ember/component';
import discourseComputed from 'discourse-common/utils/decorators';

export default Component.extend({
  tagName: 'tr',
  classNameBindings: ['isUserRow:me'],

  @discourseComputed('item')
  isUserRow(item) {
    if (item.currentUser) {
      return true;
    }
    return false;
  },

  @discourseComputed('item.dailyRankMove')
  displayRelativeRank(rank) {
    if (rank > 0) {
      return {
        rank,
        icon: 'long-arrow-alt-up',
        class: 'value-positive',
      };
    } else if (rank < 0) {
      return {
        rank,
        icon: 'long-arrow-alt-down',
        class: 'value-negative',
      };
    } else {
      return {
        rank,
        class: 'value-neutral',
      };
    }
  },
});
