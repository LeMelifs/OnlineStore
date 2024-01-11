<template>
  <q-layout view="lHh Lpr lFf">
    <HeaderComponent/>
    <q-page-container style="border: 2px solid #9C27B0">
      <div class="text-weight-bold text-grey-10 parent" style="margin: 80px 50px 10px; font-size: 32px; width: 350px ">
        Корзина
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
import BucketOrder from "components/BucketOrder.vue";
</script>
