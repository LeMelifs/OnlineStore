<template>
  <q-layout view="lHh Lpr lFf">
    <q-page-container>
      <q-page class="flex flex-center bg-grey-2">
        <q-card class="q-px-lg q-pt-md q-pb-xl shadow-2 my_card" bordered>
          <q-card-section class="text-center">
            <template v-if="awesome">
            <div class="row" style="height: 50px">
              <router-link to="/">
                <q-btn class="btn-l" flat round style="width: 40px; height: 40px; border: 1.5px solid #626262; margin-left: -20px; margin-right: 90px"><q-icon color="grey-8" name="chevron_left"></q-icon></q-btn>
              </router-link>
              <div class=" text-grey-9 text-h6 text-weight-bold q-mb-xl">=＾• ⋏ •＾=</div>
            </div>
            </template>
            <template v-else>
              <div class=" text-grey-9 text-h6 text-weight-bold q-mb-xl" style="margin-bottom: 18px">=＾• ⋏ •＾=</div>
            </template>
            <div class="text-grey-9 text-h5 text-weight-bold" style="margin-bottom: 5px">Создание аккаунта</div>
            <div v-if="awesome" class="text-grey-7 text-h7 ">Введите ваши контактные данные, чтобы<br> создать аккаунт</div>
            <div v-else class="text-grey-7 text-h7 ">Подтвердите пароль, чтобы завершить<br> создание аккаунта</div>
          </q-card-section>
          <q-form @submit.prevent="submit">
          <q-card-section>
            <template v-if="awesome">
              <div class="text-grey-9 text-weight-bold q-ma-sm" style="margin-top: -10px">Имя</div>
              <q-input dense outlined rounded color="dark" type="text" v-model="data.first_name" label="Введите ваше имя"><template v-slot:prepend></template></q-input>
              <div class="text-grey-9 text-weight-bold q-ma-sm" style="margin-top: 15px">Имя пользователя</div>
              <q-input dense outlined rounded color="dark" type="text" v-model="data.username" label="Введите имя пользователя"><template v-slot:prepend></template></q-input>
              <div class="text-grey-9 text-weight-bold q-ma-sm" style="margin-top: 15px">Телефон</div>
              <q-input dense outlined rounded color="dark" mask="+7 ###-###-##-##" v-model="data.phone_number" label="Введите телефон"><template v-slot:prepend></template></q-input>
              <div class="text-grey-9 text-weight-bold q-ma-sm" style="margin-top: 15px; margin-bottom: 10px">Выберите пол:</div>
              <input type="radio" v-model="data.gender" value="m" name="gender" class="radio" style="margin-left: 60px">
              <span>Мужчина</span>
              <input type="radio" v-model="data.gender" value="f" name="gender" class="radio" style="margin-left: 50px">
              <span>Женщина</span>
            </template>
            <template v-else>
            <div class="text-grey-9 text-weight-bold q-ma-sm" style="margin-top: -10px">Email</div>
            <q-input dense outlined rounded color="dark" type="email" v-model="data.email" label="Введите email"><template v-slot:prepend></template></q-input>
            <div class="text-grey-9 text-weight-bold q-ma-sm" style="margin-top: 15px">Пароль</div>
            <q-input dense outlined rounded color="dark" v-model="passwords.password1" type="password" label="Введите пароль"><template v-slot:prepend></template></q-input>
            <div class="text-grey-9 text-weight-bold q-ma-sm" style="margin-top: 15px">Повтор пароля</div>
            <q-input dense outlined rounded style="margin-bottom: 20px" color="dark" v-model="passwords.password2" type="password" label="Повтор пароля"><template v-slot:prepend></template></q-input>
            </template>
            <q-btn  v-if="awesome" @click="awesome = false" color="dark" rounded size="md" style="padding: 9px; margin-top: 35px" label="Продолжить" no-caps class="full-width"></q-btn>
            <q-btn  v-else color="dark" type="submit" rounded size="md" style="padding: 9px; margin-top: 25px" label="Продолжить" no-caps class="full-width"></q-btn>
            <q-btn  v-if="!awesome" @click="awesome = true" color="dark" type="submit" flat rounded size="md" style="padding: 9px; margin-top: 15px; padding-top: 8px; height: 42px" label="Назад" text-color="black" no-caps class="full-width btn-l"></q-btn>
          </q-card-section>
            <p style="text-align: center;" class="text-grey-9 text-h7">{{ error }}</p>
          </q-form>
          <q-card-section class="text-center q-pt-none q-mt-md" style="height: 10px">
            <div class="text-grey-8">Уже есть аккаунт?
              <router-link to="/login"><a class="text-grey-9 text-weight-bold">Войти</a></router-link>
            </div>
          </q-card-section>
        </q-card>
      </q-page>
    </q-page-container>
  </q-layout>
</template>

<style>
  .radio {
    accent-color: #1D1D1D;
    margin-left: 5px;
    margin-right: 5px;
  }
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
</style>

<script setup>
import { reactive } from 'vue'
import { ref } from 'vue'
import {useRouter} from "vue-router";

let awesome = ref(true)
let passwords = reactive({
  password1: '',
  password2: ''
})

const data = reactive({
    first_name: '',
    username: '',
    email: '',
    password: '',
    phone_number: '',
    gender: ''
  }
)
const router = useRouter()

let error = ref('')
const submit = async () => {
  error.value = ''
  if (data.first_name !== '' && data.username !== '' && data.phone_number !== '' && data.email !== ''
    && data.gender !== '' && passwords.password1 !== '' && passwords.password2 !== '') {
    if (passwords.password1 === passwords.password2) {
      data.password = passwords.password1
      const response = await fetch('https://onlinestore.poslam.ru/api/v1/auth/signup', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        credentials: 'include',
        body: JSON.stringify(data),
      })
      if (response.status !== 400)
        await router.push('/login')
      else {
        let text = await response.json()
        error.value = text['detail']
      }
    } else error.value = 'Пароли не совпадают!'
  }
  else error.value = 'Заполните все поля!'
}

</script>
