class AddUserIdTasks < ActiveRecord::Migration[6.0]
  def up
    # これで、今まで作られたtasksが全部削除される。既存のtasksがある状態でユーザーと関連付けると、Not Null制約に引っかかる。
    # なので、一度削除してから、カラムを追加している
    execute 'DELETE FROM tasks'
    add_reference :tasks, :user, null: false, inex: true
  end

  def down
    remove_reference :tasks, :user, index: true
  end
end
