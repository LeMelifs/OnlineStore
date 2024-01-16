const routes = [
  {
    path: '/login',
    name: 'login',
    component: () => import('pages/LoginPage.vue')
  },
  {
    path: '/reset',
    component: () => import('pages/ResetPassword.vue')
  },
  {
    path: '/registration',
    component: () => import('pages/RegistrationPage.vue')
  },
  {
    path: "/",
    component: () => import('pages/MainPage.vue')
  },
  {
    path: "/categories",
    component: () => import('pages/CategoriesPage.vue')
  },
  {
    path: "/about",
    component: () => import('pages/AboutUsPage.vue')
  },
  {
    path: "/account",
    name: 'account',
    component: () => import('pages/AccountPage.vue')
  },
  {
    path: "/bucket",
    name: 'bucket',
    component: () => import('pages/BucketPage.vue')
  },
  {
    path: "/payment",
    name: 'payment',
    component: () => import('pages/PaymentPage.vue')
  },
  {
    path: "/product/:id?",
    name: 'Product',
    props: true,
    component: () => import('pages/ProductPage.vue')
  },
    {
    path: "/change_password",
    name: 'change_password',
    component: () => import('pages/ChangePassword.vue')
  }
]

export default routes
