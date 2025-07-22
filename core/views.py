from django.shortcuts import render, redirect
from django.contrib.auth import login, logout
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.views.decorators.cache import never_cache
from django.views.decorators.csrf import csrf_protect
from .forms import CustomLoginForm

@never_cache
@csrf_protect
def login_view(request):
    """
    Vista para el inicio de sesión
    """
    # Si el usuario ya está autenticado, redirigir al dashboard
    if request.user.is_authenticated:
        return redirect('core:dashboard')
    
    form = CustomLoginForm()
    
    if request.method == 'POST':
        form = CustomLoginForm(data=request.POST)
        
        if form.is_valid():
            user = form.get_user()
            login(request, user)
            
            # Manejar "recordarme"
            if not form.cleaned_data.get('remember_me'):
                request.session.set_expiry(0)  # Cerrar al cerrar navegador
            
            messages.success(request, f'¡Bienvenido {user.get_full_name() or user.username}!')
            
            # Redirigir a la página solicitada o al dashboard
            next_page = request.GET.get('next', 'core:dashboard')
            return redirect(next_page)
        else:
            messages.error(request, 'Usuario o contraseña incorrectos.')
    
    context = {
        'form': form,
        'page_title': 'Iniciar Sesión',
        'show_header': False,  # No mostrar header en login
    }
    
    return render(request, 'core/login.html', context)

def logout_view(request):
    """
    Vista para cerrar sesión
    """
    logout(request)
    messages.info(request, 'Has cerrado sesión exitosamente.')
    return redirect('core:login')

@login_required
def dashboard_view(request):
    """
    Vista del dashboard (después del login)
    """
    context = {
        'page_title': 'Dashboard',
        'user': request.user,
    }
    
    return render(request, 'core/dashboard.html', context)