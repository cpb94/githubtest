$PBExportHeader$w_cartera_pagos.srw
forward
global type w_cartera_pagos from w_ventana_padre_aplicaciones
end type
end forward

global type w_cartera_pagos from w_ventana_padre_aplicaciones
string title = "Módulo de Cartera de Pagos"
string menuname = "mi_cartera_pagos"
string icon = "C:\BMP\Monedas.ico"
end type
global w_cartera_pagos w_cartera_pagos

on w_cartera_pagos.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "mi_cartera_pagos" then this.MenuID = create mi_cartera_pagos
end on

on w_cartera_pagos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;//str_parametros lstr_param
//OpenSheetWithParm(w_cartera_pagos_arbol,lstr_param, w_cartera_pagos, 3,Original!)
end event

