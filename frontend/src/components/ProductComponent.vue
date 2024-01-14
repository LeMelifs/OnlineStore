<template>
  <div style="width: 20%; height: 300px" class="q-mx-sm">
    <router-link to="/product">
      <div class="bg-brown-2 q-mx-md q-mr-sm q-pa-xl parent" style="border-radius: 15px">
        <div v-if="props.photo[0]" style="width: 120px; height: 120px; overflow: hidden; border-radius: 20px; position: relative;">
          <img :src="props.photo[0]" alt="Avatar" style="width: 100%; height: 100%; object-fit: cover; position: absolute; top: 0; left: 0;">
        </div>
        <q-icon v-else size="180px" color="dark" name="mood" />
      </div>
    </router-link>
    <router-link to="/product">
      <div class="text-weight-bold text-grey-10 text-h6 q-mt-md" style="margin-left: 21px">
        {{ props.name }}
      </div>
    </router-link>
    <div class="text-grey-6  q-mt-xs" style="margin-left: 21px">
      {{ props.description }}
    </div>
    <div class="text-weight-bold text-grey-10 text-h6 q-mt-xs" style="margin-left: 21px">
      {{ props.price }}
    </div>
  </div>
</template>

<style>
.parent {
  display: flex;
  justify-content: center;
}
a {
  color: transparent;
}
</style>

<script setup>

const props = defineProps({
    id: Number,
    name: String,
    price: Number,
    description: String,
    category_id: Number,
    photo: Array
})

function d() {
  console.log(props.photo[0])
}

</script>
