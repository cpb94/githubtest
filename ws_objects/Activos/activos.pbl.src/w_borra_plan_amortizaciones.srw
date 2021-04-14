$PBExportHeader$w_borra_plan_amortizaciones.srw
forward
global type w_borra_plan_amortizaciones from w_int_con_empresa
end type
type st_1 from statictext within w_borra_plan_amortizaciones
end type
type em_delemento from u_em_campo within w_borra_plan_amortizaciones
end type
type st_2 from statictext within w_borra_plan_amortizaciones
end type
type em_helemento from u_em_campo within w_borra_plan_amortizaciones
end type
type st_helemento from statictext within w_borra_plan_amortizaciones
end type
type cb_1 from u_boton within w_borra_plan_amortizaciones
end type
type cb_2 from u_boton within w_borra_plan_amortizaciones
end type
type st_delemento from statictext within w_borra_plan_amortizaciones
end type
type kk from structure within w_borra_plan_amortizaciones
end type
end forward

type kk from structure
	string		empresa
	decimal {0}	elemento
	integer		amortizacion
	decimal {0}	ejercicio
	decimal {0}	clase_inmobilizado
	string		familia
	decimal {0}	bien
	decimal {0}	periodo
	string		tipo_amor
	decimal {0}	porcentaje_amor
	string		cuenta_activo
	string		cuenta_cargo
	string		cuenta_abono
	string		seccion
	string		centro_coste
	date		fecha_contable
	decimal {0}	asiento
	string		actualizado
	date		fecha_amor
	decimal {0}	importe_amor
	decimal {0}	importe_amorfis
	string		clase_amor
end type

global type w_borra_plan_amortizaciones from w_int_con_empresa
integer width = 2761
integer height = 660
string title = "Generación de Amortizaciones"
st_1 st_1
em_delemento em_delemento
st_2 st_2
em_helemento em_helemento
st_helemento st_helemento
cb_1 cb_1
cb_2 cb_2
st_delemento st_delemento
end type
global w_borra_plan_amortizaciones w_borra_plan_amortizaciones

type variables


end variables

forward prototypes
public subroutine f_proceso ()
end prototypes

public subroutine f_proceso ();DataStore	ds_elementos
String		cadena
Integer		rr,xx
Dec			elemento
Boolean		ok

cadena = "select empresa,elemento FROM act_bienesdet WHERE act_bienesdet.empresa = '" +& 
			codigo_empresa + "' AND act_bienesdet.elemento between " +&
			em_delemento.text + " and " + em_helemento.text + " " +&
			"AND act_bienesdet.fechabaja is null"
//ds_elementos = f_cargar_cursor(cadena)		

f_Cargar_cursor_nuevo(cadena, ds_elementos)

rr = ds_elementos.RowCount()

FOR xx = 1 to rr	
	
	elemento = ds_elementos.GetItemDecimal(xx,"elemento")	
	
    DELETE FROM act_amortizaciones
     WHERE act_amortizaciones.empresa = :codigo_empresa
       AND act_amortizaciones.elemento = :elemento
       AND act_amortizaciones.actualizado = "N";

NEXT

destroy ds_elementos
end subroutine

on w_borra_plan_amortizaciones.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_delemento=create em_delemento
this.st_2=create st_2
this.em_helemento=create em_helemento
this.st_helemento=create st_helemento
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_delemento=create st_delemento
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_delemento
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.em_helemento
this.Control[iCurrent+5]=this.st_helemento
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.st_delemento
end on

on w_borra_plan_amortizaciones.destroy
call super::destroy
destroy(this.st_1)
destroy(this.em_delemento)
destroy(this.st_2)
destroy(this.em_helemento)
destroy(this.st_helemento)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_delemento)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Eliminación del Plan de Amortizaciones" 
valor_empresa = True
This.title = istr_parametros.s_titulo_ventana

 Integer registros
 String 	cadena
 
 Select count(*) Into :registros From act_bienesdet
 Where  act_bienesdet.empresa = :codigo_empresa;
 IF registros>0  Then
	
	Select max(act_bienesdet.elemento)
		Into   :em_helemento.text
		From   act_bienesdet
	Where  act_bienesdet.empresa = :codigo_empresa;
	
	cadena = f_desc_bienesdet(codigo_empresa,Dec(em_helemento.text))
	st_helemento.text = cadena
	
	Select min(act_bienesdet.elemento)
		Into   :em_delemento.text
		From   act_bienesdet
	Where  act_bienesdet.empresa = :codigo_empresa;
	
	cadena = f_desc_bienesdet(codigo_empresa,Dec(em_delemento.text))
	st_delemento.text = cadena

END IF

end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_borra_plan_amortizaciones
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_borra_plan_amortizaciones
end type

type st_empresa from w_int_con_empresa`st_empresa within w_borra_plan_amortizaciones
end type

type st_1 from statictext within w_borra_plan_amortizaciones
integer x = 37
integer y = 224
integer width = 485
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde Elemento"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_delemento from u_em_campo within w_borra_plan_amortizaciones
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 526
integer y = 220
integer width = 393
integer taborder = 10
alignment alignment = right!
end type

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_bienesdet"
   ue_titulo         = "AYUDA SELECCION ELEMENTOS DE AMORTIZACION"
   ue_filtro         = ""
end event

event modificado;call super::modificado;String 	cadena

cadena = f_desc_bienesdet(codigo_empresa,Dec(this.text))

If cadena='' then
	f_mensaje("Aviso","El elemento no existe.")
	em_delemento.SetFocus()
	return
Else
	st_delemento.text = cadena
End If

end event

type st_2 from statictext within w_borra_plan_amortizaciones
integer x = 55
integer y = 360
integer width = 466
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Hasta Elemento"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_helemento from u_em_campo within w_borra_plan_amortizaciones
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 526
integer y = 356
integer width = 393
integer taborder = 20
alignment alignment = right!
end type

event getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_act_bienesdet"
   ue_titulo         = "AYUDA SELECCION ELEMENTOS DE AMORTIZACION"
   ue_filtro         = ""
end event

event modificado;call super::modificado;String 	cadena

cadena = f_desc_bienesdet(codigo_empresa,Dec(this.text))

If cadena='' then
	f_mensaje("Aviso","El elemento no existe.")
	em_helemento.SetFocus()
	return
Else
	st_helemento.text = cadena
End If

end event

type st_helemento from statictext within w_borra_plan_amortizaciones
integer x = 928
integer y = 360
integer width = 1129
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type cb_1 from u_boton within w_borra_plan_amortizaciones
integer x = 2240
integer y = 216
integer width = 329
integer height = 108
integer taborder = 40
string text = "&Procesar"
end type

event clicked;IF isnull(em_delemento.text) or trim(em_delemento.text)='' THEN
	f_mensaje("Error","Introduzca el elemento desde.")
	em_delemento.SetFocus()
	Return
END IF


IF isnull(em_helemento.text) or trim(em_helemento.text)='' THEN
	f_mensaje("Error","Introduzca el elemento hasta.")
	em_helemento.SetFocus()
	Return
END IF


IF Dec(em_helemento.text) < Dec(em_delemento.text) THEN
	f_mensaje("Error","DESDE MAYOR QUE HASTA")
	em_delemento.SetFocus()
	Return
END IF

f_proceso()

f_mensaje("","Proceso de borrado finalizado.")
end event

type cb_2 from u_boton within w_borra_plan_amortizaciones
integer x = 2240
integer y = 344
integer width = 329
integer height = 108
integer taborder = 50
string text = "&Salir"
end type

event clicked;call super::clicked;Close(Parent)
end event

type st_delemento from statictext within w_borra_plan_amortizaciones
integer x = 928
integer y = 224
integer width = 1129
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

