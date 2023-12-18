<script setup>
import {reactive, ref} from "vue";
import axios from 'axios';
import {useRouter} from "vue-router";

const data = reactive({
    username: '',
    password: ''
  }
)

const router = useRouter()

const submit = async () => {
  await fetch('http://127.0.0.1:8000/api/login', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    credentials: 'include',
    body: JSON.stringify(data)
  })
  await router.push('/main')
}
</script>

<template>
  <q-form @submit.prevent="submit">
  <br>
  <q-input outlined v-model="data.username" type="text" label="Логин"></q-input>
  <br>
  <q-input outlined v-model="data.password" type="password" label="Пароль"></q-input>
  <br>
  <q-btn color="primary" style="width: 100px" type="submit">Войти</q-btn>
  <br>
  </q-form>
</template>

<style scoped>

</style>
