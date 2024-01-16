import { createStore } from 'vuex'
import createPersistedState from 'vuex-persistedstate'

export default createStore({
  plugins: [createPersistedState({ storage: window.sessionStorage })],
  state: {
    authenticated: false,
    token: null,
    refresh_token: null,
    type: null,
    products: null,
    order: []
  },
  mutations: {
    SET_AUTH: (state, auth) => state.authenticated = auth,
    SET_TOKEN: (state, token) =>
        state.token = token,
    SET_REFRESH_TOKEN: (state, refresh_token) =>
        state.refresh_token = refresh_token,
    SET_TYPE: (state, type) =>
        state.type = type,
    SET_PRODUCTS: (state, products) =>
        state.products = products,
    SET_ORDER: (state, order) =>
        state.order = order
    },
  actions: {
    setAuth: ({commit}, auth) => commit('SET_AUTH', auth),
    setToken: ({commit}, token) => commit('SET_TOKEN', token),
    setRefreshToken: ({commit}, refresh_token) => commit('SET_REFRESH_TOKEN', refresh_token),
    setType: ({commit}, type) => commit('SET_TYPE', type),
    setProducts: ({commit}, products) => commit('SET_PRODUCTS', products),
    setOrder: ({commit}, order) => commit('SET_ORDER', order)
  },
  modules: {}
})
