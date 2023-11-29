module ApplicationHelper

  def nav_items
    if user_signed_in?
      signed_nav_items
    else
      guest_nav_items
    end
  end

  private
  def signed_nav_items
    [
      {
        icon: "fa-solid fa-house",
        path: user_path(current_user),
        text: "Home"
      },
      {
        icon: "fa-solid fa-users",
        path: users_path,
        text: "Users"
      },
      {
        icon: "fa-solid fa-book-open",
        path: books_path,
        text: "Books"
      },
      {
        icon: "fa-solid fa-sign-out-alt",
        path: destroy_user_session_path,
        text: "Log out",
        method: :delete
      }
    ]
  end

  def guest_nav_items
    [
      {
        icon: "fa-solid fa-house",
        path: root_path,
        text: "Home"
      },
      {
        icon: "fa-solid fa-link",
        path: about_path,
        text: "About"
      },
      {
        icon: "fa-solid fa-user-plus",
        path: new_user_registration_path,
        text: "Sign up"
      },
      {
        icon: "fa-solid fa-sign-in-alt",
        path: new_user_session_path,
        text: "Log in"
      }
    ]
  end
end
