<template>
  <q-layout view="lHh Lpr lFf">
        <q-page-container>
          <HeaderComponent/>
           <div class="text-weight-bold text-grey-10 text-h5 parent" style="position: fixed; text-align: center; left: 50%; top: 10%; transform: translate(-50%, 0);">
        Добро пожаловать!
      </div>
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

const url_view = 'https://onlinestore.poslam.ru/api/v1/user/view'
const url_refresh = 'https://onlinestore.poslam.ru/api/v1/auth/refresh'

onMounted(async () => {
  try {
    const response = await fetch(url_view, {
      method: 'GET',
      headers: {'auth': `${store.state.token}`},
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
