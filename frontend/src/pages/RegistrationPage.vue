<template>
  <q-layout view="lHh Lpr lFf">
    <q-page-container>
      <q-page class="flex flex-center bg-grey-2">
        <q-card class="q-px-lg q-pt-md q-pb-xl shadow-2 my_card" bordered>
          <q-card-section class="text-center">
            <div class="text-grey-9 text-h6 text-weight-bold q-mb-xl ">=＾• ⋏ •＾=</div>
            <div class="text-grey-9 text-h5 text-weight-bold" style="margin-bottom: 5px">Создание аккаунта</div>
            <div v-if="awesome" class="text-grey-7 text-h7 ">Введите ваши контактные данные, чтобы создать аккаунт</div>
            <div v-else class="text-grey-7 text-h7 ">Подтвердите пароль, чтобы завершить создание аккаунта</div>
          </q-card-section>
          <q-card-section>
            <template v-if="awesome">
              <div class="text-grey-9 text-weight-bold q-ma-sm">Имя пользователя</div>
              <q-input dense outlined rounded color="dark" v-model="email" label="Введите имя пользователя"><template v-slot:prepend></template></q-input>
              <div class="text-grey-9 text-weight-bold q-ma-sm">Email</div>
              <q-input dense outlined rounded color="dark" v-model="email" label="Введите email"><template v-slot:prepend></template></q-input>
              <div class="text-grey-9 text-weight-bold q-ma-sm" style="margin-top: 15px">Телефон</div>
              <q-input dense outlined rounded color="dark" class="" v-model="password" label="Введите телефон"><template v-slot:prepend></template></q-input>
              <div class="text-grey-9 text-weight-bold q-ma-sm" style="margin-top: 15px; margin-bottom: 10px">Выберите пол:</div>
              <input type="radio" name="gender" value="male" class="radio" style="margin-left: 60px">
              <span>Мужчина</span>
              <input type="radio" name="gender" value="female" class="radio" style="margin-left: 50px">
              <span>Женщина</span>

            </template>
            <template v-else>
              <div class="text-grey-9 text-weight-bold q-ma-sm" style="margin-top: 15px">Пароль</div>
            <q-input dense outlined rounded color="dark" v-model="password" type="password" label="Введите пароль"><template v-slot:prepend></template></q-input>
            <div class="text-grey-9 text-weight-bold q-ma-sm" style="margin-top: 15px">Повтор пароля</div>
            <q-input dense outlined rounded color="dark" v-model="password" type="password" label="Повтор пароля"><template v-slot:prepend></template></q-input>
            </template>
            <q-btn  @click="awesome = !awesome" color="dark" rounded size="md" style="padding: 9px; margin-top: 15px" label="Продолжить" no-caps class="full-width"></q-btn>
          </q-card-section>
          <q-card-section class="text-center q-pt-none q-mt-lg">
            <div class="text-grey-8">Уже есть аккаунт?
              <router-link to="/"><a class="text-grey-9 text-weight-bold">Войти</a></router-link></div>

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

<script>
import { defineComponent } from 'vue'
import { ref } from 'vue'
export default defineComponent({
  name: 'RegistrationPage',
  setup() {
    return {
      awesome: ref(true),
    }
  },
})
</script>
