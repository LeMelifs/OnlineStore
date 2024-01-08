<template>
  <q-layout view="lHh Lpr lFf">

        <q-page-container>
          <HeaderComponent/>
           <div class="text-weight-bold text-grey-10 text-h5 parent" style="position: fixed; text-align: center; left: 50%; top: 10%; transform: translate(-50%, 0);">
        Добро пожаловать!
      </div>
    </q-page-container>
    <FooterComponent/>
  </q-layout>
</template>

<style scoped>
</style>

<script setup>
import HeaderComponent from "components/HeaderComponent.vue";
import FooterComponent from "components/FooterComponent.vue";
import BucketOrder from "components/BucketOrder.vue";


</script>
