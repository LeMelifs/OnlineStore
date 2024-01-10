<script setup>

import FooterComponent from "components/FooterComponent.vue";
import HeaderComponent from "components/HeaderComponent.vue";
import {reactive, ref} from "vue";
import store from "src/store";

const data = reactive({
    old: '',
    new: ''
  }
)

let error = ref('')

const submit = async () => {
  error.value = ''
  const response = await fetch('https://onlinestore.poslam.ru/api/v1/auth/change_password', {
    method: 'POST',
    headers: {'Content-Type': 'application/json', 'auth': `${store.state.token}`},
    credentials: 'include',
    body: JSON.stringify(data)
  })
  let json = await response.json()
  error.value = json['detail']
}
</script>

<template>
  <q-layout view="lHh Lpr lFf">
        <q-page-container>
          <HeaderComponent/>
            <q-page class="flex flex-center bg-grey-2">
             <q-card class="q-px-lg q-pt-md q-pb-xl shadow-2 my_card" bordered>
               <q-card-section class="text-center">
            <div class="text-grey-9 text-h5 text-weight-bold" style="margin-bottom: 5px">Смена пароля</div>
            <div class="text-grey-7 text-h7 ">Введите ваш старый пароль от аккаунта в целях безопасности, затем новый пароль</div>
            </q-card-section>
            <q-form @submit.prevent="submit">
            <q-card-section>
            <div class="text-grey-9 text-weight-bold q-ma-sm">Старый пароль</div>
            <q-input dense outlined rounded color="dark" v-model="data.old" type="password" label="Введите старый пароль"><template v-slot:prepend></template></q-input>
            <div class="text-grey-9 text-weight-bold q-ma-sm" style="margin-top: 15px">Новый пароль</div>
            <q-input dense outlined rounded color="dark" v-model="data.new" type="password" label="Введите новый пароль"><template v-slot:prepend></template></q-input>
            <q-btn color="dark" type="submit" rounded size="md" style="padding: 9px; margin-top: 57px" label="Сохранить" no-caps class="full-width"></q-btn>
            <router-link to="/account">
            <q-btn color="dark" flat rounded size="md" style=" margin-top: 15px; height: 41px" label="Назад" text-color="black" no-caps class="full-width btn-l"></q-btn>
            </router-link>
            </q-card-section>
            </q-form>
            <p class="text-grey-9 text-h7" style="text-align: center;">{{ error }}</p>
          </q-card>
      </q-page>
    </q-page-container>
    <FooterComponent/>
  </q-layout>
</template>

<style scoped>
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
