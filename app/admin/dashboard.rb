# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Recent Menus Added" do
          table_for Menu.order(created_at: :desc).limit(5) do
            column(:id)
            column(:title) { |menu| link_to menu.title, admin_menu_path(menu) }
            column(:created_at)
          end
          div { link_to "View All Menus", admin_menus_path }
        end
      end

      column do
        panel "Recent Dishes Added" do
          table_for Dish.order(created_at: :desc).limit(5) do
            column(:id)
            column(:title) { |dish| link_to dish.title, admin_dish_path(dish) }
            column(:price)
          end
          div { link_to "View All Dishes", admin_dishes_path }
        end
      end

      column do
        panel "Recent Orders" do
          table_for Order.order(created_at: :desc).limit(5) do
            column(:id)
            column(:user)
            column(:status)
          end
          div { link_to "View All Orders", admin_orders_path }
        end
      end
    end
  end
end
