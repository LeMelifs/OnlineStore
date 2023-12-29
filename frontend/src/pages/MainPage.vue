<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>
    <FooterComponent/>
  </q-layout>
</template>

<style scoped>
</style>

<script setup>
import HeaderComponent from "components/HeaderComponent.vue";
import FooterComponent from "components/FooterComponent.vue";
import {computed, onMounted, ref} from "vue";
import store from "../store";

</script>
