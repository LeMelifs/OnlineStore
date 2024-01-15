<template>
  <q-layout view="lHh Lpr lFf">
    <q-page-container>
      <q-page class="flex flex-center bg-grey-2">
        <q-card class="q-px-lg q-pt-md q-pb-xl shadow-2 my_card" bordered>
          <q-card-section class="text-center">
            <div class="text-grey-9 text-h6 text-weight-bold q-mb-xl ">=＾• ⋏ •＾=</div>
            <div class="text-grey-9 text-h5 text-weight-bold" style="margin-bottom: 5px">Восстановление пароля</div>
            <div  class="text-grey-7 text-h7 ">Укажите свой адрес электронной почты, мы отправим вам электронное письмо с кодом для смены пароля</div>
          </q-card-section>
          <q-form @submit.prevent="submit">
          <q-card-section>
              <div v-if="state === 'email'" class="text-grey-9 text-weight-bold q-ma-sm">Почта</div>
              <div v-if="state === 'code'" class="text-grey-9 text-weight-bold q-ma-sm">Код</div>
              <div v-if="state === 'password'" class="text-grey-9 text-weight-bold q-ma-sm">Новый пароль</div>
              <q-input v-if="state === 'email'" dense outlined rounded color="dark" v-model="data.email" label="Введите email"><template v-slot:prepend></template></q-input>
              <q-input v-if="state === 'code'" dense outlined rounded color="dark" v-model="data.code" label="Введите код"><template v-slot:prepend></template></q-input>
              <q-input v-if="state === 'password'" dense outlined rounded color="dark" v-model="data.password" label="Введите новый пароль"><template v-slot:prepend></template></q-input>
          </q-card-section>
          <q-card-section>
            <div class="row" >
              <router-link to="/login">
                <q-btn v-if="state !== 'success'" class="btn-l" color="dark" rounded outline size="md" style="padding: 9px" label="Отмена" no-caps ></q-btn>
              </router-link>
                <q-btn v-if="state !== 'password' && state !== 'success'" type="submit" class="btn-r" color="dark" rounded size="md" style="padding: 9px" label="Отправить" no-caps ></q-btn>
                <q-btn v-if="state === 'password'" type="submit" class="btn-r" color="dark" rounded size="md" style="padding: 9px" label="Сохранить" no-caps ></q-btn>
            </div>
            <router-link to="/login">
            <q-btn v-if="state === 'success'" color="dark" size="md" type="submit" rounded style="padding: 9px;" label="Вернуться на страницу авторизации" no-caps class="full-width"></q-btn>
            </router-link>
            <p class="text-grey-9 text-h7" style="text-align: center; margin-top: 15px">{{ error }}</p>
          </q-card-section>
        </q-form>
        </q-card>
      </q-page>
    </q-page-container>
  </q-layout>
</template>
<style>

.btn-l {
  width: 152px;
  margin-right: 10px;
  border: 1.5px solid black;
}
.btn-r {
  width: 152px;
  margin-left: 10px;

}
.my_card {
  width: 450px;
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
import {reactive, ref} from "vue";

let error = ref('')
let state = ref('email')

const url = 'https://onlinestore.poslam.ru/api/v1/auth/forgot_password'
const params = new URLSearchParams();

const data = reactive({
    email: '',
    code: '',
    password: ''
  }
)

const submit = async () => {
  error.value = ''
  if (state.value === 'email') {
    params.append('email', data.email);
  }
  else if (state.value === 'code') {
    params.append('code', data.code);
  }
  else if (state.value === 'password') {
    params.append('password', data.password);
  }
  const fullUrl = `${url}?${params.toString()}`;
  const response = await fetch(fullUrl, {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    credentials: 'include'
  })
  let json = await response.json()
  error.value = json['detail']
  if (response.status !== 400) {
    if (state.value === 'password') {
      state.value = 'success'
    }
    else {
      state.value = state.value === 'email' ? 'code' : 'password'
    }
  }
}

</script>
