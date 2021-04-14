$PBExportHeader$w_int_prompanexpositores.srw
forward
global type w_int_prompanexpositores from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_prompanexpositores
end type
type uo_expositor from u_em_campo_2 within w_int_prompanexpositores
end type
type st_3 from statictext within w_int_prompanexpositores
end type
type uo_grupo from u_em_campo_2 within w_int_prompanexpositores
end type
type em_descripcion from u_em_campo within w_int_prompanexpositores
end type
type st_8 from statictext within w_int_prompanexpositores
end type
type st_6 from statictext within w_int_prompanexpositores
end type
type dw_1 from u_datawindow_consultas within w_int_prompanexpositores
end type
type dw_detalle from datawindow within w_int_prompanexpositores
end type
type dw_sumas from datawindow within w_int_prompanexpositores
end type
end forward

global type w_int_prompanexpositores from w_int_con_empresa
integer width = 2894
integer height = 1740
pb_1 pb_1
uo_expositor uo_expositor
st_3 st_3
uo_grupo uo_grupo
em_descripcion em_descripcion
st_8 st_8
st_6 st_6
dw_1 dw_1
dw_detalle dw_detalle
dw_sumas dw_sumas
end type
global w_int_prompanexpositores w_int_prompanexpositores

type variables
string filtro
Integer  contador
String marcado
Editmask campo
end variables

forward prototypes
public subroutine f_control ()
public subroutine f_filtro (string tipo)
end prototypes

public subroutine f_control ();String expositor,descripcion,cod1,cod2,tipo_expositor
cod1 = "."
cod2 = "Z"
dec lineas

IF Trim(uo_grupo.em_codigo.text) <> "" Then
  cod1 = uo_grupo.em_codigo.text
  cod2 = uo_grupo.em_codigo.text
END IF

descripcion    = "%"+em_descripcion.text+"%"
tipo_expositor = f_tipo_promcabexpositores(codigo_empresa,uo_expositor.em_codigo.text)
expositor      = uo_expositor.em_codigo.text
//dw_1.Retrieve(codigo_empresa,tipo_expositor,descripcion,cod1,cod2,expositor)
dw_1.Retrieve(codigo_empresa,expositor)
dw_sumas.Retrieve(codigo_empresa,expositor)

end subroutine

public subroutine f_filtro (string tipo);IF tipo = "S" Then
		dw_1.Setfilter("control='X'")
		dw_1.Filter()
		marcado = "N"
ELSE
		dw_1.Setfilter("control=''")
		dw_1.Filter()
		marcado = "S"
END IF
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Introducción Mapa Expositores"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)
dw_sumas.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)
dw_detalle.SetTransObject(SQLCA)
marcado= "N"
//f_filtro(marcado)
 // Si recibo el codigo lo visualizo
 IF istr_parametros.i_nargumentos>1 THEN
     uo_expositor.em_codigo.text=istr_parametros.s_argumentos[2]
     uo_expositor.em_campo.text=f_nombre_promcabexpositores(codigo_empresa,istr_parametros.s_argumentos[2])
	  uo_expositor.TriggerEvent("modificado")
     //f_activar_campo(em_descripcion)
	  Return
END IF
f_activar_campo(uo_expositor.em_campo)

end event

on w_int_prompanexpositores.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_expositor=create uo_expositor
this.st_3=create st_3
this.uo_grupo=create uo_grupo
this.em_descripcion=create em_descripcion
this.st_8=create st_8
this.st_6=create st_6
this.dw_1=create dw_1
this.dw_detalle=create dw_detalle
this.dw_sumas=create dw_sumas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_expositor
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.uo_grupo
this.Control[iCurrent+5]=this.em_descripcion
this.Control[iCurrent+6]=this.st_8
this.Control[iCurrent+7]=this.st_6
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.dw_detalle
this.Control[iCurrent+10]=this.dw_sumas
end on

on w_int_prompanexpositores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_expositor)
destroy(this.st_3)
destroy(this.uo_grupo)
destroy(this.em_descripcion)
destroy(this.st_8)
destroy(this.st_6)
destroy(this.dw_1)
destroy(this.dw_detalle)
destroy(this.dw_sumas)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event activate;call super::activate;w_int_prompanexpositores = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_prompanexpositores
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_prompanexpositores
integer y = 4
integer taborder = 20
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_descripcion)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_int_prompanexpositores
integer x = 27
integer y = 8
integer width = 2427
end type

event st_empresa::getfocus;call super::getfocus;f_activar_campo(em_descripcion)
end event

type pb_1 from upb_salir within w_int_prompanexpositores
integer x = 2711
integer y = 8
integer width = 128
integer height = 112
integer taborder = 0
end type

type uo_expositor from u_em_campo_2 within w_int_prompanexpositores
integer x = 110
integer y = 192
integer width = 878
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de expositores"
ue_datawindow = "dw_ayuda_promcabexpositores"
ue_filtro     = ""
campo = uo_expositor.em_campo
end on

event modificado;uo_expositor.em_campo.text=f_nombre_promcabexpositores(codigo_empresa,uo_expositor.em_codigo.text)
IF Trim(uo_expositor.em_campo.text)="" THEN 
 IF Trim(uo_expositor.em_codigo.text)<>"" Then uo_expositor.em_campo.SetFocus()
 uo_expositor.em_campo.text=""
 uo_expositor.em_codigo.text=""
END IF
f_control()
 
end event

on uo_expositor.destroy
call u_em_campo_2::destroy
end on

type st_3 from statictext within w_int_prompanexpositores
integer x = 110
integer y = 120
integer width = 882
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
string text = "Expositor"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_grupo from u_em_campo_2 within w_int_prompanexpositores
boolean visible = false
integer x = 987
integer y = 192
integer width = 416
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de grupos"
ue_datawindow = "dw_ayuda_promgrupos"
ue_filtro     = ""
campo = uo_grupo.em_campo
end on

on modificado;call u_em_campo_2::modificado;uo_grupo.em_campo.text=f_nombre_promgrupos(codigo_empresa,uo_grupo.em_codigo.text)
IF Trim(uo_grupo.em_campo.text)="" THEN 
 IF Trim(uo_grupo.em_codigo.text)<>"" Then uo_grupo.em_campo.SetFocus()
 uo_grupo.em_campo.text=""
 uo_grupo.em_codigo.text=""
END IF

f_control()
 
end on

on uo_grupo.destroy
call u_em_campo_2::destroy
end on

type em_descripcion from u_em_campo within w_int_prompanexpositores
boolean visible = false
integer x = 1403
integer y = 192
integer width = 1257
integer taborder = 10
end type

on getfocus;call u_em_campo::getfocus;campo = this
end on

event tecla_enter;call super::tecla_enter;f_control()
end event

event modificado;call super::modificado;f_control()
end event

type st_8 from statictext within w_int_prompanexpositores
boolean visible = false
integer x = 1408
integer y = 120
integer width = 1253
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
string text = "Descripción"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_int_prompanexpositores
boolean visible = false
integer x = 992
integer y = 120
integer width = 416
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
string text = "Grupo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_1 from u_datawindow_consultas within w_int_prompanexpositores
integer x = 110
integer y = 284
integer width = 2345
integer height = 648
integer taborder = 0
string dataobject = "dw_int_prompanexpositores1"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;String panel
IF dw_1.GetRow() =0 Then Return
panel = dw_1.GetItemString(dw_1.GetRow(),"codigo")
dw_detalle.Retrieve(codigo_empresa,panel)
end event

event doubleclicked;Integer linea,lin
Dec{2}  pesomaterial,costematerial,ventamaterial,pesopanel,costepanel,ventapanel,coste_manipulacion,var_canpantipo,var_canpantipoped
String expositor,panel,controles,tipo,clase,medida
expositor = uo_expositor.em_codigo.text

lin=  row

IF lin =0 THEN Return

controles          = dw_1.GetItemString(lin,"control")
panel              = dw_1.GetItemString(lin,"codigo")
pesomaterial       = f_pesomaterial_prompaneles(codigo_empresa,panel)
costematerial      = f_costematerial_prompaneles(codigo_empresa,panel)
ventamaterial      = f_pventamaterial_prompaneles(codigo_empresa,panel)
tipo               = f_tipo_panel_prompaneles(codigo_empresa,panel)
IF isnull(tipo) then tipo = ""
clase              = f_clase_panel_promparam(codigo_empresa)
medida             = f_medida_promlinexpositores (codigo_empresa,f_tipo_promcabexpositores(codigo_empresa,uo_expositor.em_codigo.text),tipo)
costepanel         = f_preciocoste_promclasemedidas(codigo_empresa,clase,medida)
pesopanel          = f_peso_promclasemedidas(codigo_empresa,clase,medida)
coste_manipulacion = f_costemanipulacion_prommedidas(codigo_empresa,medida)
ventapanel         = f_precioventa_promclasemedidas(codigo_empresa,clase,medida)

IF Trim(controles)   = "" THEN
		IF f_panelmano_prompaneles(codigo_empresa,panel)="N" THEN
			var_canpantipo = f_total_tipo_paneles_expositor(codigo_empresa,f_tipo_promcabexpositores(codigo_empresa,uo_expositor.em_codigo.text),tipo)
			IF var_canpantipo  = 0 Then
			  f_mensaje("No se puede grabar la linea","Este tipo de panel no esta contemplado en el expositor: "+f_nombre_promexpositores(codigo_empresa,f_tipo_promcabexpositores(codigo_empresa,uo_expositor.em_codigo.text)))
			  Return
			ELSE	
				Select count(*) Into :var_canpantipoped From prompanexpositores
				Where  prompanexpositores.empresa    = :codigo_empresa
				And    prompanexpositores.codigo  = :uo_expositor.em_codigo.text
				And    prompanexpositores.tipo = :tipo;
				IF var_canpantipoped >= var_canpantipo Then
					f_mensaje("No se puede grabar la linea","Expositor completo en paneles de este tipo ")
					Return
				END IF
			END IF
		END IF
			 
		linea =0
		
		SELECT max(prompanexpositores.linea)  
		INTO   :linea  
		FROM   prompanexpositores  
		WHERE (prompanexpositores.empresa = :codigo_empresa ) AND  
				(prompanexpositores.codigo = :expositor );
		
		IF IsNull(linea) Then linea =0
		
		linea = linea +1
		
		INSERT INTO prompanexpositores 
  			(empresa,codigo,linea,panel,observaciones,pesomaterial,
			costematerial,ventamaterial,tipo,pesopanel,costepanel,ventapanel,coste_manipulacion)  
		VALUES (:codigo_empresa,:expositor,:linea,:panel,null,:pesomaterial,:costematerial,
			     :ventamaterial,:tipo,:pesopanel,:costepanel,:ventapanel,:coste_manipulacion);
		COMMIT;

ELSE
		DELETE FROM prompanexpositores  
		WHERE ( prompanexpositores.empresa = :codigo_empresa ) AND  
			   ( prompanexpositores.codigo  = :expositor ) AND  
			   ( prompanexpositores.panel   = :panel )   ;
		
		COMMIT;
END IF

SELECT  sum(pesomaterial),sum(costematerial),sum(ventamaterial),
	     sum(pesopanel),sum(costepanel),sum(ventapanel),
	     sum(coste_manipulacion)
INTO    :pesomaterial,:costematerial,:ventamaterial,
	     :pesopanel,:costepanel,:ventapanel,:coste_manipulacion
FROM    prompanexpositores  
WHERE   (prompanexpositores.empresa = :codigo_empresa )
AND     (prompanexpositores.codigo = :expositor);

UPDATE promcabexpositores  
SET pesomaterial       = :pesomaterial,   
	 costematerial      = :costematerial,   
	 pventamaterial     = :ventamaterial,
	 pesopanel          = :pesopanel,
	 costepanel         = :costepanel,
	 ventapanel         = :ventapanel,
	 coste_manipulacion = :coste_manipulacion
WHERE ( promcabexpositores.empresa = :codigo_empresa ) AND  
	   ( promcabexpositores.codigo = :expositor )   ;

COMMIT;

dw_sumas.Retrieve(codigo_empresa,expositor)
f_asignar_columna(dw_1,row,"empresa",codigo_empresa)
//f_activar_campo(em_descripcion)


end event

event ue_valores;call super::ue_valores;ue_marca_linea = FALSE
end event

event clicked;call super::clicked;//IF f_objeto_datawindow(This) = "marcado" Then
//	f_filtro(marcado)
//END IF
//f_activar_campo(em_descripcion)
end event

type dw_detalle from datawindow within w_int_prompanexpositores
integer x = 110
integer y = 944
integer width = 1467
integer height = 480
boolean bringtotop = true
string dataobject = "dw_int_prompanexpositores3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_sumas from datawindow within w_int_prompanexpositores
integer x = 1595
integer y = 948
integer width = 919
integer height = 392
string dataobject = "dw_int_prompanexpositores4"
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

