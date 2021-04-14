$PBExportHeader$wi_mvent_con_empresa.srw
$PBExportComments$Mantenimientos de tipo ventana con el campo empresa.
forward
global type wi_mvent_con_empresa from wi_mant_ventanas
end type
type p_logotencer from picture within wi_mvent_con_empresa
end type
type st_empresa from statictext within wi_mvent_con_empresa
end type
end forward

global type wi_mvent_con_empresa from wi_mant_ventanas
integer width = 2386
integer height = 1236
p_logotencer p_logotencer
st_empresa st_empresa
end type
global wi_mvent_con_empresa wi_mvent_con_empresa

forward prototypes
public subroutine f_inicialicar_tiempo_limite ()
end prototypes

public subroutine f_inicialicar_tiempo_limite ();If tiempo_limite >=0 Then tiempo_limite = 0
end subroutine

event open;call super::open;Int orden 

//if cerrar_sin_abrir = false then

	f_inicializar_tiempo_limite()
	dw_1.SetTransObject(SQLCA)
	
	This.Title = istr_parametros.s_titulo_ventana
	isle_campo = sle_valor
	tipo_mantenimiento ="N"
	cb_borrar.enabled    =  FALSE
	cb_insertar.enabled  =  FALSE
	IF Orden =10 THEN  isle_campo.Setfocus()
	
	
	this.Icon = 'c:\bmp\tencer.ico'
	st_empresa.Text = f_nombre_empresa (codigo_empresa)
	istr_parametros.b_empresa = TRUE
	valor_empresa             = istr_parametros.b_empresa 
	
	return
	
//end if

//call ue_postopen


end event

event resize;// Si modificamos el tamaño de la ventana:
//
//			Modificamos el tamaño del texto empresa
/*IF This.Width > 200 THEN
		st_empresa.Resize(This.width - 250, st_empresa.height)
END IF*/
end event

on wi_mvent_con_empresa.create
int iCurrent
call super::create
this.p_logotencer=create p_logotencer
this.st_empresa=create st_empresa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_logotencer
this.Control[iCurrent+2]=this.st_empresa
end on

on wi_mvent_con_empresa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_logotencer)
destroy(this.st_empresa)
end on

event ue_recuperar;call super::ue_recuperar;// Resuelve problemas de navegación entre herencias(eventos)
end event

type dw_1 from wi_mant_ventanas`dw_1 within wi_mvent_con_empresa
integer y = 344
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_1 from wi_mant_ventanas`st_1 within wi_mvent_con_empresa
integer y = 216
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within wi_mvent_con_empresa
integer x = 1833
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within wi_mvent_con_empresa
end type

type sle_valor from wi_mant_ventanas`sle_valor within wi_mvent_con_empresa
integer y = 212
boolean bringtotop = true
end type

type cb_salir from wi_mant_ventanas`cb_salir within wi_mvent_con_empresa
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within wi_mvent_con_empresa
integer width = 169
integer height = 52
end type

type p_logotencer from picture within wi_mvent_con_empresa
boolean visible = false
integer x = 1221
integer y = 160
integer width = 165
integer height = 152
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type st_empresa from statictext within wi_mvent_con_empresa
integer width = 2373
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Bookman Old Style"
long textcolor = 134217857
long backcolor = 16777215
boolean enabled = false
string text = "Empresa"
boolean focusrectangle = false
end type

