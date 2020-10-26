import Dashboard from 'components/dashboard'
// import ContestsIndex from 'components/contests/index'
// import ContestShow from 'components/contests/show'
// import CriterionsIndex from 'components/criterions/index'
// import ParticipantsIndex from 'components/participants/index'
// import ParticipantNew from 'components/participants/new'
// import ParticipantEdit from 'components/participants/edit'
// import ExpertsIndex from 'components/experts/index'
// import ExpertNew from 'components/experts/new'
// import ExpertEdit from 'components/experts/edit'
// import MarksIndex from 'components/marks/index'
// import ResultsIndex from 'components/results/index'
// import NominationsIndex from 'components/nominations/index'
// import PermissionsIndex from 'components/permissions/index'
// import PermissionNew from 'components/permissions/new'

export const routes = [
  {
    name: 'dashboard',
    path: '/',
    component: Dashboard,
    props: true//,
    // children: [
    //   {
    //     name: 'contests',
    //     path: 'contests',
    //     component: ContestsIndex,
    //     children: [
    //       {
    //         name: 'contest_show',
    //         path: '/contests/:id',
    //         component: ContestShow,
    //         children: [
    //           {
    //             name: 'criterions',
    //             path: '/contests/:id/criterions',
    //             component: CriterionsIndex
    //           },
    //           {
    //             name: 'participants',
    //             path: '/contests/:id/participants',
    //             component: ParticipantsIndex,
    //             children: [
    //               {
    //                 name: 'participant_new',
    //                 path: '/contests/:id/participants/new',
    //                 component: ParticipantNew
    //               },
    //               {
    //                 name: 'participant_edit',
    //                 path: '/contests/:id/participants/:participant_id/edit',
    //                 component: ParticipantEdit
    //               }
    //             ]
    //           },
    //           {
    //             name: 'experts',
    //             path: '/contests/:id/experts',
    //             component: ExpertsIndex,
    //             children: [
    //               {
    //                 name: 'expert_new',
    //                 path: '/contests/:id/experts/new',
    //                 component: ExpertNew
    //               },
    //               {
    //                 name: 'expert_edit',
    //                 path: '/contests/:id/experts/:expert_id/edit',
    //                 component: ExpertEdit
    //               },
    //               {
    //                 name: 'marks',
    //                 path: '/contests/:id/experts/:expert_id/marks',
    //                 component: MarksIndex
    //               }
    //             ]
    //           },
    //           {
    //             name: 'nominations',
    //             path: '/contests/:id/nominations',
    //             component: NominationsIndex
    //           },
    //           {
    //             name: 'results',
    //             path: '/contests/:id/results',
    //             component: ResultsIndex
    //           }
    //         ]
    //       }
    //     ]
    //   },
    //   {
    //     name: 'permissions',
    //     path: 'permissions',
    //     component: PermissionsIndex,
    //     children: [
    //       {
    //         name: 'permission_new',
    //         path: '/permissions/new',
    //         component: PermissionNew
    //       }
    //     ]
    //   }
    // ]
  }
]
