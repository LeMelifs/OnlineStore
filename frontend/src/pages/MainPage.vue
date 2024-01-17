<template>
  <q-layout view="lHh Lpr lFf">
        <q-page-container>
          <HeaderComponent/>
    </q-page-container>
    <FooterComponent/>
  </q-layout>
</template>
<style scoped>
</style>

<script setup>
import HeaderComponent from "components/HeaderComponent.vue";
import FooterComponent from "components/FooterComponent.vue";
import {onMounted} from "vue";
import store from "src/store";
import cookie from "vue-cookie";

const url_view = 'https://onlinestore.poslam.ru/api/v1/user/view'
const url_refresh = 'https://onlinestore.poslam.ru/api/v1/auth/refresh'

onMounted(async () => {
  const token = cookie.get('user-token')
  const refresh = cookie.get('user-refresh')
  const type = cookie.get('type')
  if (token && refresh) {
      await store.dispatch('setToken', token)
      await store.dispatch('setRefreshToken', refresh)
      await store.dispatch('setType', type)
      await store.dispatch('setAuth', true)
  }
  try {
    const response = await fetch(url_view, {
      method: 'GET',
      headers: {'Content-Type': 'application/json', 'auth': `${store.state.token}`},
    })

    if (response.status !== 200) {
      throw new Error('Ошибка!')
    }
  }
  catch (error) {
    try {
      const response = await fetch(url_refresh, {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        credentials: 'include',
        body: JSON.stringify({ refresh_token: `${store.state.refresh_token}` })
      })

      if (response.status !== 200) {
        throw new Error('Ошибка!')
      }

      const json = await response.json()

      await store.dispatch('setToken', json['token'])
      await store.dispatch('setRefreshToken', json['refresh_token'])
      await store.dispatch('setType', json['type'])
    }
    catch (error) {
      await store.dispatch('setToken', null)
      await store.dispatch('setRefreshToken', null)
      await store.dispatch('setType', null)
      await store.dispatch('setAuth', false)
    }
  }
})
</script>
