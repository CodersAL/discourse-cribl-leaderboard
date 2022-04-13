import Component from '@ember/component';
import { action } from '@ember/object';
import { equal } from '@ember/object/computed';

export default Component.extend({
  isTodays: equal('type', 'todays'),
  @action
  loadMore() {
    // TODO
  },
});
