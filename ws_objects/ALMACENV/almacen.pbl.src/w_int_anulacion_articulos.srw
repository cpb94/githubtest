$PBExportHeader$w_int_anulacion_articulos.srw
forward
global type w_int_anulacion_articulos from w_int_con_empresa
end type
type gb_1 from groupbox within w_int_anulacion_articulos
end type
type pb_1 from upb_salir within w_int_anulacion_articulos
end type
type dw_listado from datawindow within w_int_anulacion_articulos
end type
type uo_1 from u_manejo_datawindow within w_int_anulacion_articulos
end type
type pb_2 from upb_imprimir within w_int_anulacion_articulos
end type
type uo_articulo from u_em_campo_2 within w_int_anulacion_articulos
end type
type st_1 from statictext within w_int_anulacion_articulos
end type
type st_2 from statictext within w_int_anulacion_articulos
end type
type em_fecha from u_em_campo within w_int_anulacion_articulos
end type
type rb_anular from radiobutton within w_int_anulacion_articulos
end type
type rb_fin from radiobutton within w_int_anulacion_articulos
end type
type rb_ambos from radiobutton within w_int_anulacion_articulos
end type
type dw_articulos from u_datawindow_consultas within w_int_anulacion_articulos
end type
type dw_tarifas from datawindow within w_int_anulacion_articulos
end type
type dw_vendecotar from datawindow within w_int_anulacion_articulos
end type
end forward

global type w_int_anulacion_articulos from w_int_con_empresa
integer width = 2880
integer height = 1628
gb_1 gb_1
pb_1 pb_1
dw_listado dw_listado
uo_1 uo_1
pb_2 pb_2
uo_articulo uo_articulo
st_1 st_1
st_2 st_2
em_fecha em_fecha
rb_anular rb_anular
rb_fin rb_fin
rb_ambos rb_ambos
dw_articulos dw_articulos
dw_tarifas dw_tarifas
dw_vendecotar dw_vendecotar
end type
global w_int_anulacion_articulos w_int_anulacion_articulos

type variables
string filtro,anular,fin,ambos



end variables

forward prototypes
public subroutine f_proceso ()
public subroutine f_proceso1 ()
end prototypes

public subroutine f_proceso ();Integer  reg,reg1,bien,cual=0
String   var_articulo,var_activo,var_listar,var_tarifa,var_calidad,valor
Datetime var_fecha,var_fecha_fin,var_fecha_anulado

dw_tarifas.Reset()
dw_tarifas.SetRedraw(FALSE)
var_articulo = uo_articulo.em_codigo.text
dw_tarifas.Reset()

reg    = dw_tarifas.Retrieve(codigo_empresa,var_articulo)

//f_contador_procesos(reg1,reg)

if anular="N" and Fin="S" then cual=1
if anular="S" and Fin="N" then cual=2
if ambos = "S" then cual=3
IF cual=0 then
	   f_mensaje("Error en proceso","El proceso no se actualiza")
      Return
end if
	
IF reg <> 0 Then

	For reg1 = 1 To reg

		var_tarifa  = f_valor_columna(dw_tarifas,reg1,"tarifa")
		var_fecha   = dw_tarifas.GetItemDateTime(reg1,"fecha")
		var_calidad = f_valor_columna(dw_tarifas,reg1,"calidad")
					
   	choose case cual
			case 1	
				var_fecha_fin   = dw_articulos.GetItemDateTime(dw_articulos.GetRow(),"fecha_fin")
		      IF String(var_fecha_fin,"dd-mm-yy") <> "00-00-00"  and Not IsNull(var_fecha_fin)Then
               valor = "N"
				  else
               valor = "S"
            End if
				UPDATE venlintarifas  
				SET listar = :valor  	
				
						WHERE ( venlintarifas.empresa  = :codigo_empresa ) AND  
						( venlintarifas.tarifa   = :var_tarifa ) AND  
						( venlintarifas.fecha    = :var_fecha ) AND  
						( venlintarifas.articulo = :var_articulo ) AND  
						( venlintarifas.calidad =  :var_calidad )   ;
						IF Sqlca.Sqlcode <> 0 Then bien = 1
 			case 2
            var_fecha_anulado   = dw_articulos.GetItemDateTime(dw_articulos.GetRow(),"fecha_anulado")
 				IF String(var_fecha_anulado,"dd-mm-yy") <> "00-00-00"  and Not IsNull(var_fecha_anulado)Then
               valor = "N"
				  else
               valor = "S"
            End if
       		UPDATE venlintarifas  
				SET activo = :valor  	
				
						WHERE ( venlintarifas.empresa  = :codigo_empresa ) AND  
						( venlintarifas.tarifa   = :var_tarifa ) AND  
						( venlintarifas.fecha    = :var_fecha ) AND  
						( venlintarifas.articulo = :var_articulo ) AND  
						( venlintarifas.calidad =  :var_calidad )   ;
						IF Sqlca.Sqlcode <> 0 Then bien = 1
			case 3
				var_fecha_anulado   = dw_articulos.GetItemDateTime(dw_articulos.GetRow(),"fecha_anulado")
 				IF String(var_fecha_anulado,"dd-mm-yy") <> "00-00-00"  and Not IsNull(var_fecha_anulado)Then
               valor = "N"
				  else
               valor = "S"
            End if
				UPDATE venlintarifas  
				SET listar = :valor,
				    activo = :valor  	
				
						WHERE ( venlintarifas.empresa  = :codigo_empresa ) AND  
						( venlintarifas.tarifa   = :var_tarifa ) AND  
						( venlintarifas.fecha    = :var_fecha ) AND  
						( venlintarifas.articulo = :var_articulo ) AND  
						( venlintarifas.calidad =  :var_calidad )   ;
						IF Sqlca.Sqlcode <> 0 Then bien = 1
		END CHOOSE     
	Next
		  

    If bien = 1 Then
       RollBack;
       f_mensaje("Error en proceso","El proceso no se actualiza")
     ELSE
      Commit;
    END IF

 END IF

end subroutine

public subroutine f_proceso1 ();Integer  reg,reg1,bien,cual=0,reg2,reg3,numero
String   var_articulo,var_activo,var_listar,var_tarifa,var_calidad,valor
Datetime var_fecha,var_fecha_fin,var_fecha_anulado
String   var_base,var_decorado

var_articulo = uo_articulo.em_codigo.text

if anular="N" and Fin="S" then cual=1
if anular="S" and Fin="N" then cual=2
if ambos = "S" then cual=3
IF cual=0 then
	   f_mensaje("Error en proceso","El proceso no se actualiza")
      Return
end if

reg2 = dw_vendecotar.Retrieve(codigo_empresa,var_articulo)

if reg2<>0 then
	
	For reg3=1 to Reg2
		
		var_base     = f_valor_columna(dw_vendecotar,reg3,"base")
		var_decorado = f_valor_columna(dw_vendecotar,reg3,"decorado")

      Select Count(*) 
		Into   :numero 
		From   vendecotar
      Where  vendecotar.empresa  = :codigo_empresa
      And    vendecotar.decorado = :var_decorado;

      IF IsNull(numero) Then numero = 0
		
		if numero=1 then 
				reg  = dw_tarifas.Retrieve(codigo_empresa,var_decorado)
		 
				IF reg <> 0 Then
					For reg1 = 1 To reg
				
						var_tarifa  = f_valor_columna(dw_tarifas,reg1,"tarifa")
						var_fecha   = dw_tarifas.GetItemDateTime(reg1,"fecha")
						var_calidad = f_valor_columna(dw_tarifas,reg1,"calidad")
									
						choose case cual
							case 1	
								var_fecha_fin   = dw_articulos.GetItemDateTime(dw_articulos.GetRow(),"fecha_fin")
								IF String(var_fecha_fin,"dd-mm-yy") <> "00-00-00"  and Not IsNull(var_fecha_fin)Then
									valor = "N"
								  else
									valor = "S"
								End if
								UPDATE venlintarifas  
								SET listar = :valor  	
								
										WHERE ( venlintarifas.empresa  = :codigo_empresa ) AND  
										( venlintarifas.tarifa   = :var_tarifa ) AND  
										( venlintarifas.fecha    = :var_fecha ) AND  
										( venlintarifas.articulo = :var_decorado ) AND  
										( venlintarifas.calidad =  :var_calidad )   ;
										IF Sqlca.Sqlcode <> 0 Then bien = 1
							case 2
								var_fecha_anulado   = dw_articulos.GetItemDateTime(dw_articulos.GetRow(),"fecha_anulado")
								IF String(var_fecha_anulado,"dd-mm-yy") <> "00-00-00"  and Not IsNull(var_fecha_anulado)Then
									valor = "N"
								  else
									valor = "S"
								End if
								UPDATE venlintarifas  
								SET activo = :valor  	
								
										WHERE ( venlintarifas.empresa  = :codigo_empresa ) AND  
										( venlintarifas.tarifa   = :var_tarifa ) AND  
										( venlintarifas.fecha    = :var_fecha ) AND  
										( venlintarifas.articulo = :var_decorado ) AND  
										( venlintarifas.calidad =  :var_calidad )   ;
										IF Sqlca.Sqlcode <> 0 Then bien = 1
							case 3
								var_fecha_anulado   = dw_articulos.GetItemDateTime(dw_articulos.GetRow(),"fecha_anulado")
								IF String(var_fecha_anulado,"dd-mm-yy") <> "00-00-00"  and Not IsNull(var_fecha_anulado)Then
									valor = "N"
								  else
									valor = "S"
								End if
								UPDATE venlintarifas  
								SET listar = :valor,
									 activo = :valor  	
								
										WHERE ( venlintarifas.empresa  = :codigo_empresa ) AND  
										( venlintarifas.tarifa   = :var_tarifa ) AND  
										( venlintarifas.fecha    = :var_fecha ) AND  
										( venlintarifas.articulo = :var_decorado ) AND  
										( venlintarifas.calidad =  :var_calidad )   ;
										IF Sqlca.Sqlcode <> 0 Then bien = 1
						END CHOOSE     
					Next 
				  
		
					If bien = 1 Then
						RollBack;
						f_mensaje("Error en proceso","El proceso no se actualiza")
					 ELSE
						Commit;
					END IF
			End if
     END IF
  
  Next 
End if
end subroutine

event ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
dw_report.retrieve(codigo_empresa)
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end event

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta, asignacion articulos anulados"
This.title=istr_parametros.s_titulo_ventana

dw_articulos.SetTransObject(SQLCA)
dw_tarifas.SetTransObject(SQLCA)
dw_vendecotar.SetTransObject(SQLCA)
dw_articulos.Retrieve(codigo_empresa)
em_fecha.text = String(Today())
rb_anular.checked = TRUE
rb_fin.checked    = FALSE
anular = "S"
fin = "N"

f_activar_campo(uo_articulo.em_campo)

end event

on w_int_anulacion_articulos.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.uo_1=create uo_1
this.pb_2=create pb_2
this.uo_articulo=create uo_articulo
this.st_1=create st_1
this.st_2=create st_2
this.em_fecha=create em_fecha
this.rb_anular=create rb_anular
this.rb_fin=create rb_fin
this.rb_ambos=create rb_ambos
this.dw_articulos=create dw_articulos
this.dw_tarifas=create dw_tarifas
this.dw_vendecotar=create dw_vendecotar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.pb_2
this.Control[iCurrent+6]=this.uo_articulo
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.em_fecha
this.Control[iCurrent+10]=this.rb_anular
this.Control[iCurrent+11]=this.rb_fin
this.Control[iCurrent+12]=this.rb_ambos
this.Control[iCurrent+13]=this.dw_articulos
this.Control[iCurrent+14]=this.dw_tarifas
this.Control[iCurrent+15]=this.dw_vendecotar
end on

on w_int_anulacion_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.uo_1)
destroy(this.pb_2)
destroy(this.uo_articulo)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_fecha)
destroy(this.rb_anular)
destroy(this.rb_fin)
destroy(this.rb_ambos)
destroy(this.dw_articulos)
destroy(this.dw_tarifas)
destroy(this.dw_vendecotar)
end on

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_1.TriggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_1.TriggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_articulos)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_articulos)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_anulacion_articulos
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_anulacion_articulos
integer taborder = 30
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_articulo.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_int_anulacion_articulos
integer x = 27
integer y = 8
integer width = 2427
end type

type gb_1 from groupbox within w_int_anulacion_articulos
integer x = 1691
integer y = 92
integer width = 370
integer height = 212
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type pb_1 from upb_salir within w_int_anulacion_articulos
integer x = 2679
integer y = 4
integer width = 123
integer height = 112
integer taborder = 0
end type

type dw_listado from datawindow within w_int_anulacion_articulos
boolean visible = false
integer width = 494
integer height = 124
integer taborder = 50
boolean bringtotop = true
string dataobject = "report_articulos_anulados"
boolean livescroll = true
end type

type uo_1 from u_manejo_datawindow within w_int_anulacion_articulos
integer x = 2167
integer y = 168
integer height = 148
end type

event valores;call super::valores;dw_data       = dw_articulos
dw_data.SetTransObject(SQLCA)
f_activar_campo(uo_articulo.em_campo)
end event

on uo_1.destroy
call u_manejo_datawindow::destroy
end on

type pb_2 from upb_imprimir within w_int_anulacion_articulos
integer x = 2642
integer y = 216
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")
f_activar_campo(uo_articulo.em_campo)
end event

type uo_articulo from u_em_campo_2 within w_int_anulacion_articulos
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 343
integer y = 176
integer width = 731
integer height = 96
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;Integer    reg
uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF
IF Trim(uo_articulo.em_codigo.text ) <> "" Then
 reg = dw_articulos.find("codigo = '"+uo_articulo.em_codigo.text+"'",1,dw_articulos.RowCount())
 dw_articulos.ScrollToRow(reg)
END IF
 
end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""
end on

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type st_1 from statictext within w_int_anulacion_articulos
integer x = 64
integer y = 188
integer width = 274
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Artículo:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_int_anulacion_articulos
integer x = 1102
integer y = 188
integer width = 197
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha:"
boolean focusrectangle = false
end type

type em_fecha from u_em_campo within w_int_anulacion_articulos
integer x = 1303
integer y = 180
integer width = 274
integer taborder = 0
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = " "
end type

type rb_anular from radiobutton within w_int_anulacion_articulos
integer x = 1737
integer y = 136
integer width = 288
integer height = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Baja"
end type

event clicked;rb_anular.checked   = TRUE
rb_fin.checked      = FALSE
rb_ambos.checked    = FALSE

anular = "S"
fin    = "N"
ambos  = "N"

f_activar_campo(uo_articulo.em_campo)
end event

type rb_fin from radiobutton within w_int_anulacion_articulos
integer x = 1737
integer y = 192
integer width = 288
integer height = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Liquidar"
end type

event clicked;rb_anular.checked = FALSE
rb_fin.checked    = TRUE
rb_ambos.checked  = FALSE

anular = "N"
fin    = "S"
ambos  = "N"

f_activar_campo(uo_articulo.em_campo)
end event

type rb_ambos from radiobutton within w_int_anulacion_articulos
event clicked pbm_bnclicked
integer x = 1737
integer y = 248
integer width = 288
integer height = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Ambos"
end type

event clicked;rb_anular.checked = FALSE
rb_fin.checked    = FALSE
rb_ambos.checked  = TRUE

anular = "N"
fin    = "N"
ambos  = "S"

f_activar_campo(uo_articulo.em_campo)
end event

type dw_articulos from u_datawindow_consultas within w_int_anulacion_articulos
integer x = 55
integer y = 336
integer width = 2715
integer height = 1068
integer taborder = 0
string dataobject = "dw_int_anulacion_articulos1"
borderstyle borderstyle = styleraised!
end type

event doubleclicked;call super::doubleclicked;if row=0 Then Return

String cod_articulo,motivo,tex,activo
Integer    reg,opcion
DateTime   fecha
Datetime fecha_fin,fecha_anulado
fecha = Datetime(Date(em_fecha.text))

cod_articulo = String(dw_articulos.GetItemString(This.GetRow(),"codigo"))

IF Trim(cod_articulo) <> "" Then

 
 fecha_fin     = dw_articulos.GetItemDateTime(row,"fecha_fin")
 fecha_anulado = dw_articulos.GetItemDateTime(row,"fecha_anulado")


 IF fin= "S" Then
   	
		tex="NO LISTAR"
	   IF String(fecha_fin,"dd-mm-yy") <> "00-00-00"  AND NOT IsNull(fecha_fin) Then tex="SI LISTAR"
 	   motivo="El artículo sera marcado como "+tex+" en tarifas."
      opcion = MessageBox(motivo,"¿Desea continuar?",question!, YesNo!,2)
      
		If opcion = 2 THEN
      	f_activar_campo(uo_articulo.em_campo)
      	Return
      End if 

		IF String(fecha_fin,"dd-mm-yy") <> "00-00-00"  AND NOT IsNull(fecha_fin)Then
		  SetNull(fecha)
	   End if
  		
		Update articulos Set  fecha_fin = :fecha
  		Where  articulos.empresa  =  :codigo_empresa
  		And    articulos.codigo   =  :cod_articulo;
		COMMIT;
		dw_articulos.SetItem(row,"fecha_fin",fecha)
		
END IF

IF anular= "S" Then
      IF String(fecha_anulado,"dd-mm-yy") <> "00-00-00"  and Not IsNull(fecha_anulado)Then
	 		  SetNull(fecha)
			 activo = "S"
		   ELSE
				activo = "N"
			  IF String(fecha_fin,"dd-mm-yy") = "00-00-00"  or IsNull(fecha_fin)Then
				  f_mensaje("No se puede anular este articulo"," No se puede anular un articulo sin fecha de fin de producción")
				  Return
			  END IF
			  IF Date(String(fecha_fin,"dd-mm-yy")) > Date(fecha) Then
				  f_mensaje("No se puede anular este articulo"," No se puede anular un articulo con fecha de fin de producción no vencida")
				  Return
			  END IF
		END IF
   	
		tex="sera marcado como ANULADO"
   	IF String(fecha_anulado,"dd-mm-yy") <> "00-00-00"  AND NOT IsNull(fecha_anulado) Then tex="se marcara como ACTIVO"
		motivo="El artículo "+tex+" en tarifas."
      opcion = MessageBox(motivo,"¿Desea continuar?",question!, YesNo!,2)
		If opcion = 2 THEN
      	f_activar_campo(uo_articulo.em_campo)
      	Return
      End if 

		Update articulos Set  fecha_anulado = :fecha,
									 activo        = :activo
		Where  articulos.empresa  =  :codigo_empresa
		And    articulos.codigo   =  :cod_articulo;
		COMMIT;
		dw_articulos.SetItem(row,"fecha_anulado",fecha)
END IF

  
If ambos="S" then
	   IF String(fecha_fin,"dd-mm-yy") <> "00-00-00"  AND NOT IsNull(fecha_fin)Then
		  SetNull(fecha)
	   End if
      tex="ANULADO Y NO LISTAR"
		IF String(fecha_fin,"dd-mm-yy") <> "00-00-00"  AND NOT IsNull(fecha_fin) Then tex="ACTIVO Y LISTAR"
		motivo="El artículo sera marcado como "+tex+" en tarifas."
      opcion = MessageBox(motivo,"¿Desea continuar?",question!, YesNo!,2)
      If opcion = 2 THEN
      	f_activar_campo(uo_articulo.em_campo)
      	Return
      End if 

		Update articulos Set  fecha_fin = :fecha
  		Where  articulos.empresa  =  :codigo_empresa
  		And    articulos.codigo   =  :cod_articulo;
		COMMIT;
		dw_articulos.SetItem(row,"fecha_fin",fecha)
		activo = "N"
      IF String(fecha_anulado,"dd-mm-yy") <> "00-00-00"  and Not IsNull(fecha_anulado)Then
		    SetNull(fecha)
  		   activo = "S"
	   END IF

      
      Update articulos Set  fecha_anulado = :fecha,
									 activo        = :activo
		Where  articulos.empresa  =  :codigo_empresa
		And    articulos.codigo   =  :cod_articulo;
		COMMIT;
		dw_articulos.SetItem(row,"fecha_anulado",fecha)
  End if

END IF
f_proceso()
f_proceso1()
end event

type dw_tarifas from datawindow within w_int_anulacion_articulos
boolean visible = false
integer x = 517
integer y = 8
integer width = 457
integer height = 112
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_proceso_anula_venlitarifas"
boolean livescroll = true
end type

type dw_vendecotar from datawindow within w_int_anulacion_articulos
boolean visible = false
integer x = 1019
integer y = 8
integer width = 471
integer height = 104
integer taborder = 32
boolean bringtotop = true
string dataobject = "dw_proceso_vendecotar"
boolean livescroll = true
end type

