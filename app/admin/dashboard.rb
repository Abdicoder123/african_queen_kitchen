# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    panel "African Queen Kitchen's Admin Dashboard Overview" do
      div do
        h3 "This is where you can access all your menus, dishes, orders, and invoices."
        h3 "You can click 'View All' on each dashboard OR you can click on the titles in the navigation bar."
      end
    end

    columns do
      column do
        panel "Most Recent Orders" do
          table_for Order.order(created_at: :desc).limit(5) do
            column(:id)
            column(:user)
            column(:status)
          end
          div { link_to "View All Orders", admin_orders_path }
        end
      end

      column do
        panel "Most Recent Invoices" do
          table_for Invoice.order(created_at: :desc).limit(5) do
            column(:id)
            column(:user)
            column(:invoice_status)
          end
          div { link_to "View All Invoices", admin_invoices_path }
        end
      end

      column do
        panel "All of Your Menus" do
          table_for Menu.order(created_at: :desc).limit(5) do
            column(:id)
            column(:title) { |menu| link_to menu.title, admin_menu_path(menu) }
          end
          div { link_to "View All Menus", admin_menus_path }
        end
      end

      column do
        panel "All of Your Dishes" do
          table_for Dish.order(created_at: :desc).limit(5) do
            column(:id)
            column(:title) { |dish| link_to dish.title, admin_dish_path(dish) }
            column(:price)
          end
          div { link_to "View All Dishes", admin_dishes_path }
        end
      end
    end
  end
end
