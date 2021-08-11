 User.create!(
   email: "mail1@gmail.com",
   password: "password1",
   name: "ニックネーム1"
 )

 User.create!(
   email: "mail2@gmail.com",
   password: "password2",
   name: "ニックネーム2"
 )


 5.times do |n|
   Goal.create!(
     user_id: 1,
     content: "#{(n + 1)}個めの目標"
   )

   Report.create!(
     goal_id: n + 1,
     comment: "#{n + 1}日目！頑張った！！",
     fulness: 0.1,
     task_all: (n + 1),
     task_progress: 1
   )

   Category.create!(
     name: "カテゴリ#{n + 1}"
   )

   Share.create!(
     user_id: 1,
     goal_id: n + 1,
     category_id: n + 1,
     content: "#{n + 10}日で達成したよ！",
     copy_count: (n + 1)
   )

   Task.create!(
     goal_id: n + 1,
     week: 0,
     content: "#{n + 1}個めのタスク"
   )

   TaskWork.create!(
     goal_id: n + 1,
     task_id: n + 1
   )


   Help.create!(
     title: "ヘルプ#{n + 1}",
     body: "内容#{n + 1}"
   )

   Clip.create!(
    user_id: 2,
    share_id: n + 1
    )

  end