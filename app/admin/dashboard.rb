# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    columns do
      column do
        panel "Recent Menus" do
          table_for Menu.order(created_at: :desc).limit(5) do
            column(:id)
            column(:title) { |menu| link_to menu.title, admin_menu_path(menu) }
            column(:created_at)
          end
          div { link_to "View All Menus", admin_menus_path }
        end
      end

      column do
        panel "Recent Dishes" do
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
            column(:total_price)
          end
          div { link_to "View All Orders", admin_orders_path }
        end
      end
    end
  end
end
