<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>

    <q-page-container>
      <div class=" q-gutter-md row items-start" style="margin: 100px 200px ">
        <q-card style=" width: 380px; box-shadow: none; border-radius: 25px">
          <q-btn  @click="orders" flat icon="local_shipping"  text-color="grey-10" class="btn_start full-width  text-weight-bold" label="Мои заказы" :style="{border: order ? '2px solid #3a3a3a' : ''}" no-caps ><q-icon style="margin-left: 205px" name="chevron_right"></q-icon></q-btn>
          <q-btn  @click="manage_acc" flat icon="settings" text-color="grey-10" class="btn_center_dark full-width text-weight-bold" label="Управление аккаунтом" :style="{border: manage ? '2px solid #3a3a3a' : ''}" no-caps ><q-icon style="margin-left: 130px" name="chevron_right"></q-icon></q-btn>
          <q-btn  @click="delivery" flat icon="room" text-color="grey-10" class="btn_center_light full-width text-weight-bold" label="Адреса доставки" :style="{border: deliver ? '2px solid #3a3a3a' : ''}" no-caps ><q-icon style="margin-left: 165px" name="chevron_right"></q-icon></q-btn>
          <router-link to="/login">
            <q-btn @click="logout" flat icon="logout" text-color="grey-10" class="btn_end full-width text-weight-bold" label="Выход" no-caps ><q-icon style="margin-left: 235px" name="chevron_right"></q-icon></q-btn>
          </router-link>
        </q-card>
        <template v-if="manage">
          <q-card style=" width: 650px; box-shadow: none; border-radius: 25px; margin-top: -38px;">
            <div class="text-weight-bold text-grey-10" style="margin: -10px 150px 20px; font-size: 30px; width: 350px ">Управление аккаунтом</div>
            <div class="q-pa-md" style="width: 640px; border-radius: 25px; background-color: #f6f6f6; margin-bottom: -100px">
              <div class="row">
                <q-card style="box-shadow: none; border-radius: 25px; height: 150px">
                  <q-card-section class="bg-brown-2">
                    <q-icon size="120px" color="dark" name="account_circle" />
                  </q-card-section>
                </q-card>
                <q-btn flat rounded style="width: 50px; height: 50px; background-color: #ffffff; border: 1px solid #a4a4a4; margin: 100px 0px 0px -20px" dense icon="edit"></q-btn>
                <q-input dense outlined rounded color="dark" style="width: 410px; background-color: white; border-radius: 25px; height: 40px; margin: 110px 0px 0px 15px"  v-model='first_name' label="Ваше имя"><template v-slot:prepend></template></q-input>
                <q-input dense outlined rounded color="dark" style="width: 410px; background-color: white; border-radius: 25px; height: 40px; margin: 110px 0px 0px 15px" v-model='username' label="Имя пользователя"><template v-slot:prepend></template></q-input>
              </div>
              <div style="margin: 50px 0px 4px 15px; font-size: 14px">Почта</div>
              <q-btn style="border: 1px solid #a4a4a4; padding: 7px 0px 7px 10px; font-size: 15px" rounded flat text-color="grey-10" class="full-width text-weight-bold"  :label="email" no-caps ><q-icon style="margin-left: 450px" name="chevron_right"></q-icon></q-btn>
              <div style="margin: 15px 0px 4px 15px; font-size: 14px">Телефон</div>
              <q-btn style="border: 1px solid #a4a4a4;margin: 0px 0px 50px 0px; padding: 7px 0px 7px 10px" rounded flat text-color="grey-10" class="full-width text-h7 text-weight-bold" :label="phone_number" no-caps ><q-icon style="margin-left: 420px" name="chevron_right"></q-icon></q-btn>
              <q-btn>Сохранить</q-btn> <br>
              <router-link to="/change_password">
                <a class="text-grey-9 text-weight-bold" style="margin: 0px 0px 4px 10px;">Изменить пароль</a>
              </router-link>
              <div style="margin: 15px 0px 4px 10px;">
                <router-link to="/">
                  <a class="text-grey-9 text-weight-bold" >Удалить аккаунт</a>
                </router-link>
              </div>
            </div>
          </q-card>
        </template>
        <template v-if="order">
          <q-card style=" width: 380px; box-shadow: none; border-radius: 25px; margin-top: -38px">
            <div class="text-weight-bold text-grey-10" style="margin: -10px 270px 20px; font-size: 30px ">Заказы</div>
            <div class="q-pa-md" style="width: 640px; border-radius: 25px; background-color: #f6f6f6;">
              <div class="row q-mb-xl">
                <q-btn @click="change_f" flat rounded :style="{border: active ? '1px solid #3a3a3a' : '2.5px solid #3a3a3a'}" label="Активные" no-caps class="btn_change text-weight-bold text-grey-10"></q-btn>
                <q-btn @click="change_t" flat rounded :style="{border: active ? '2.5px solid #3a3a3a' : '1px solid #3a3a3a'}" label="Архив" no-caps class="btn_change text-weight-bold q-ml-sm text-grey-10 "></q-btn>
              </div>

              <template v-if="active">
                <div class="q-pl-sm" style="font-size: 14.5px; ">У вас нет заказов в архиве</div>
                <q-separator color="grey-5" class="q-mt-md q-mb-sm"/>
              </template>
              <template v-else>
                <div class="q-pl-sm" style="font-size: 14.5px; ">У вас нет активных заказов</div>
                <q-separator color="grey-5" class="q-mt-md q-mb-sm"/>
              </template>
            </div>
          </q-card>
        </template>
        <template v-if="deliver">
          <q-card style=" box-shadow: none; border-radius: 25px; margin-top: -38px;">
            <div class="text-weight-bold text-grey-10" style="margin: -10px 15px 20px; font-size: 30px;padding-left: 40px">Адреса доставки</div>
            <div class="q-pa-lg" style=" border-radius: 25px; background-color: #f6f6f6; margin-bottom: -100px;">
              <q-icon name="person" style="font-size: 25px" />
              <span style="margin: 5px 0px 4px 15px; font-size: 14px; font-weight: bold">Имя Фамилия Отчество, +7 (123) 456-78-90</span>
              <div class="q-mt-sm q-mb-md">
                <q-icon name="room" style="font-size: 25px" />
                <span style="margin: 5px 0px 4px 15px; font-size: 14px;">Улица 12, кв. 34</span>
                <div style="margin-left: 40px">Владивосток г, Приморский край, 120034</div>
              </div>
              <router-link to="/">
                <a class="text-grey-9 text-weight-bold" style="margin: 0px 0px 4px 40px;">Редактировать</a>
              </router-link>
              <span style="margin: 10px 0px 4px 10px;">
                <router-link to="/">
                  <a class="text-grey-9 text-weight-bold" >Удалить</a>
                </router-link>
              </span>
            </div>
          </q-card>
        </template>
        <template v-else>
        </template>
      </div>
    </q-page-container>
    <FooterComponent/>
  </q-layout>
</template>

<style scoped>
a {
  color: #2f2f2f;
}
.btn_start{
  padding: 9px 9px 9px 15px;
  border-start-start-radius: 25px;
  border-start-end-radius: 25px;
  background-color: #f6f6f6;
}
.btn_center_dark{
  padding: 9px 9px 9px 15px;
  border-radius: 0px;
  border-bottom: 0px solid #b0b0b0;
  border-top: 0px solid #b0b0b0;
  background-color: #eeeeee;
}
.btn_center_light{
  padding: 9px 9px 9px 15px;
  border-radius: 0px;
  border-bottom: 0px solid #b0b0b0;
  border-top: 0px solid #b0b0b0;
  background-color: #f6f6f6;
}
.btn_end{
  padding: 9px 9px 9px 15px;
  border-end-end-radius: 24px;
  border-end-start-radius: 24px;
  background-color: #eeeeee;
}
.btn_change{
  padding: 8px;
  width: 300px;
  background-color: white;
  font-size: 16px;
}
</style>

<script setup>
import HeaderComponent from "components/HeaderComponent.vue";
import FooterComponent from "components/FooterComponent.vue";
import {onMounted, ref} from "vue";
import store from "src/store";

let active = ref(false)
let order = ref(false)
let manage = ref(false)
let deliver = ref(false)

onMounted(() => {
  order.value = true;
  manage.value = false;
  deliver.value = false;
})

function logout() {
  store.dispatch('setToken', null)
  store.dispatch('setRefreshToken', null)
  store.dispatch('setType', null)
  store.dispatch('setAuth', false)
}

function change_t() {
  active.value = true;
}

function change_f() {
  active.value = false;
}

function manage_acc() {
  order.value = false;
  manage.value = true;
  deliver.value = false;
}

function orders() {
  order.value = true;
  manage.value = false;
  deliver.value = false;
}

function delivery() {
  order.value = false;
  manage.value = false;
  deliver.value = true;
}

let username = ''
let first_name = ''
let email = ''
let gender = ''
let phone_number = ''

onMounted(async () => {
  const response = await fetch('https://onlinestore.poslam.ru/api/v1/user/view', {
    method: 'GET',
    headers: {'auth': `${store.state.token}`},
  })
  const json = await response.json()
  if (response.status !== 404) {
    username = json['username']
    first_name = json['first_name']
    email = json['email']
    gender = json['gender']
    phone_number = json['phone_number']
  }
})


</script>

