<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>
    <q-page-container class="parent">
      <div class="text-weight-bold text-grey-10 parent q-mt-xl" style="font-size: 32px; width: 350px ">
        О нас
      </div>
      <div>
        <img src="../assets/cat_img.jpg" style="border-radius: 100%; height: 50px">
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
</script>
