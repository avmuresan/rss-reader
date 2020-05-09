import Api from '@application/api';

export default ({ commit }, { feedId }) => {
  const path = `/feeds/${feedId}`;

  return Api.delete(path).then((response) => {
    commit('remove', response.data.feed.id);

    return response.data.feed;
  });
};
