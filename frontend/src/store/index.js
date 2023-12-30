import { createStore } from 'vuex'
import {ref} from "vue";

export default createStore({
  state: {
    authenticated: false,
    token: null,
    refresh_token: null,
    type: null
  },
  mutations: {
    SET_AUTH: (state, auth) => state.authenticated = auth,
    SET_TOKEN: (state, token) =>
        state.token = token,
    SET_REFRESH_TOKEN: (state, refresh_token) =>
        state.refresh_token = refresh_token,
    SET_TYPE: (state, type) =>
        state.type = type
    },
  actions: {
    setAuth: ({commit}, auth) => commit('SET_AUTH', auth),
    setToken: ({commit}, token) => commit('SET_TOKEN', token),
    setRefreshToken: ({commit}, refresh_token) => commit('SET_REFRESH_TOKEN', refresh_token),
    setType: ({commit}, type) => commit('SET_TYPE', type),
  },
  modules: {}
})
