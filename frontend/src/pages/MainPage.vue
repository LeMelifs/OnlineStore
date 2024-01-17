<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>
    <q-page-container>
      <div class="parent">
        <div class=" text-weight-bold text-h4" style="margin-top: 30px;">Добро пожаловать!</div>
      </div>
      <div class="parent">
        <div class="row  q-pa-md parent" style="border-radius: 25px; margin-top: 25px; border: 1px solid #c2c2c2">
          <div class="text-weight-bold text-grey-10 text-h5 q-ma-md" >
            Наша история: от первой<br>идеи до любимого магазина<br>с котиками
          </div>
          <q-separator vertical class="q-mx-lg"></q-separator>
          <div class="q-ma-md" style="width: 550px; text-align: justify">
            В начале нашего пути стояла одна простая идея — сочетать стиль моды с бескрайней милотой котиков. С каждым шагом, каждым швом и улыбкой наших клиентов, мы превращали эту идею в реальность. Сегодня наш магазин стал вашим уголком моды и радости, где каждая деталь рассказывает свою уникальную историю.
          </div>
        </div>
      </div>

      <div class="row parent q-mb-xl">
        <div class="row">
          <div class="bg-grey-2 q-pa-md " style="border-radius: 25px; margin-top: 50px">
            <div class="text-weight-bold text-grey-10 text-h5 q-ma-md" >
              Миссия и Ценности:
            </div>
            <div class="q-ma-md" style="width: 250px; text-align: justify">
              Наша миссия не ограничивается созданием красивой одежды. Мы стремимся приносить радость и комфорт вашим пушистикам, предоставляя им стильные и безопасные наряды. Наши ценности лежат в основе каждого пошива, в каждом материале, и в каждом моменте, когда ваш котенок счастлив и уверен в своем облике.
            </div>
          </div>
        </div>

        <div class="row q-mx-xl">
          <div class="bg-grey-2 q-pa-md " style="border-radius: 25px; margin-top: 50px">
            <div class="text-weight-bold text-grey-10 text-h5 q-ma-md" >
              Команда:
            </div>
            <div class="q-ma-md" style="width: 250px; text-align: justify">
              Наши дизайнеры — это не просто специалисты по моде, это настоящие ценители котиков. Каждый член нашей команды вкладывает свою страсть и талант в создание уникальных дизайнов. Мы не просто шьем одежду, мы создаем волшебство, которое дарит вашему питомцу особенный стиль и удовольствие.
            </div>
          </div>
        </div>

        <div class="row">
          <div class="bg-grey-2 q-pa-md " style="border-radius: 25px; margin-top: 50px">
            <div class="text-weight-bold text-grey-10 text-h5 q-ma-md" >
              Наше Вдохновение:
            </div>
            <div class="q-ma-md" style="width: 250px; text-align: justify">
              Мы глубоко вдохновлены нашими пушистыми друзьями, и это видно в каждой нашей коллекции. Разгадайте секреты, заложенные в каждом узоре и цвете, и почувствуйте ту уникальную энергию, которую приносит в мир стиль, созданный под влиянием миролюбивых глаз наших котиков.
            </div>
          </div>
        </div>
      </div>
    </q-page-container>
    <FooterComponent/>
  </q-layout>
</template>

<style scoped>
.parent {
  display: flex;
  justify-content: center;
}
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
