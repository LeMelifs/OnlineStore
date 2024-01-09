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
    path: "/account",
    name: 'account',
    component: () => import('pages/AccountPage.vue')
  },
  {
    path: "/bucket",
    component: () => import('pages/BucketPage.vue')
  }
]

export default routes
