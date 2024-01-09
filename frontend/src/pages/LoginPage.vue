<template>
  <q-layout view="lHh Lpr lFf">
    <q-page-container>
      <q-page class="flex flex-center bg-grey-2">
        <q-card class="q-px-lg q-pt-md q-pb-xl shadow-2 my_card" bordered>
          <q-card-section class="text-center">
            <div class="text-grey-9 text-h6 text-weight-bold q-mb-xl ">=＾• ⋏ •＾=</div>
            <div class="text-grey-9 text-h5 text-weight-bold" style="margin-bottom: 5px">Вход в аккаунт</div>
            <div class="text-grey-7 text-h7 ">Войдите, чтобы получить доступ к своему аккаунту</div>
          </q-card-section>
          <q-form @submit.prevent="submit">
          <q-card-section>
            <div class="text-grey-9 text-weight-bold q-ma-sm">Имя пользователя</div>
            <q-input dense outlined rounded color="dark" type="text" v-model="data.login" label="Введите имя пользователя"><template v-slot:prepend></template></q-input>
            <div class="text-grey-9 text-weight-bold q-ma-sm" style="margin-top: 15px">Пароль</div>
            <q-input dense outlined rounded color="dark" v-model="data.password" type="password" label="Введите пароль"><template v-slot:prepend></template></q-input>
            <div style="margin-top: 5px; margin-bottom: -10px">
<!--              <input type="checkbox" checked id="checkbox" />-->
<!--              <label for="checkbox"></label>-->
<!--              <div class="text-grey-8 text-h7 q-ml-md">Запомнить меня</div>-->
              <router-link to="/reset"><a class="text-grey-9 text-weight-bold" style="margin-left: 200px;">Забыли пароль?</a></router-link>
            </div>
          </q-card-section>
          <q-card-section>
              <q-btn color="dark" size="md" type="submit" rounded style="padding: 9px;" label="Войти" no-caps class="full-width"></q-btn>
          </q-card-section>
            <p class="text-grey-9 text-h7" style="text-align: center">{{ error }}</p>
          </q-form>
          <q-card-section class="text-center q-pt-none q-mt-xl">
            <div class="text-grey-8">В первый раз здесь?
              <router-link to="/registration"><a class="text-grey-9 text-weight-bold">Создайте аккаунт</a></router-link></div>
          </q-card-section>
        </q-card>
      </q-page>
    </q-page-container>
  </q-layout>
</template>

<style>
  .my_card {
    width: 440px;
    padding-left: 40px;
    padding-right: 40px;
    border-radius: 50px;
    box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
  }
  a {
    color: transparent;
  }
  .round {
    position: relative;
    margin-top: 10px;
    margin-left: 5px
  }

  .round label {
    background-color: #fff;
    border: 1px solid #b2b2b2;
    border-radius: 50%;
    cursor: pointer;
    height: 20px;
    left: 0;
    position: absolute;
    top: 0;
    width: 20px;
  }

  .round label:after {
    border: 2px solid #fff;
    border-top: none;
    border-right: none;
    content: "";
    height: 5px;
    left: 5px;
    opacity: 0;
    position: absolute;
    top: 6px;
    transform: rotate(-45deg);
    width: 9px;
  }

  .round input[type="checkbox"] {
    visibility: hidden;
  }

  .round input[type="checkbox"]:checked + label {
    background-color: #2f2f2f;
    border-color: #3a3a3a;
  }

  .round input[type="checkbox"]:checked + label:after {
    opacity: 1;
  }


</style>

<script setup>
import {useRouter} from "vue-router";
import {reactive, ref} from "vue";
import store from "src/store";
let error = ref('')
const data = reactive({
    login: '',
    password: ''
  }
)
const router = useRouter()
const submit = async () => {
  error.value = ''
  const response = await fetch('https://onlinestore.poslam.ru/api/v1/auth/login', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    credentials: 'include',
    body: JSON.stringify(data)
  })
  let json = await response.json()
  if (response.status !== 400) {
      await router.push('/')
      await store.dispatch('setToken', json['token'])
      await store.dispatch('setRefreshToken', json['refresh_token'])
      await store.dispatch('setType', json['type'])
      await store.dispatch('setAuth', true)
  }
  else {
    error.value = json['detail']
  }
}

</script>
