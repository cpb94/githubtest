$PBExportHeader$wi_mant_articulos_coste_lote.srw
$PBExportComments$Mantenimiento zonas de ubicaciones.
forward
global type wi_mant_articulos_coste_lote from wi_mvent_con_empresa
end type
type st_articulo from statictext within wi_mant_articulos_coste_lote
end type
type st_articulo_des from statictext within wi_mant_articulos_coste_lote
end type
type sle_articulo from u_em_campo within wi_mant_articulos_coste_lote
end type
type cb_1 from commandbutton within wi_mant_articulos_coste_lote
end type
end forward

global type wi_mant_articulos_coste_lote from wi_mvent_con_empresa
integer width = 3040
integer height = 1704
st_articulo st_articulo
st_articulo_des st_articulo_des
sle_articulo sle_articulo
cb_1 cb_1
end type
global wi_mant_articulos_coste_lote wi_mant_articulos_coste_lote

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();
dw_1.Retrieve(codigo_empresa,sle_articulo.text,sle_valor.Text)

end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de costes lotes"
//istr_parametros.s_listado        = "dw_articulos_coste_lote"
istr_parametros.s_listado        = ""
This.title=istr_parametros.s_titulo_ventana
tipo_mantenimiento = 'C'

string articulo,lote,operacion

long fila

IF istr_parametros.i_nargumentos >= 2 THEN
		
		if not isnull(istr_parametros.s_argumentos[1]) and istr_parametros.s_argumentos[1] <> "" then
			articulo = istr_parametros.s_argumentos[1]
			if not isnull(istr_parametros.s_argumentos[2]) and istr_parametros.s_argumentos[2] <> "" then
				lote = istr_parametros.s_argumentos[2]
				if dw_1.retrieve (codigo_empresa, articulo, lote) <> 1 then
					
					fila = dw_1.insertrow(0)
				

					dw_1.setitem(fila,"empresa",codigo_empresa)
					dw_1.setitem(fila,"articulo",sle_articulo.text)
					dw_1.setitem(fila,"lote",sle_valor.text)
					dw_1.setitem(fila,"version",'1')
					select art_ver_operaciones.tipo_operacion
							into :operacion
							from art_ver_operaciones 
							where ( art_ver_operaciones.empresa = :codigo_empresa ) AND  
							( art_ver_operaciones.articulo = :sle_articulo.text ) AND  
							( art_ver_operaciones.version = '1' );
					dw_1.setitem(fila,"operacion",operacion)

					
				end if
			end if
		end if
END IF

end event

on ue_buscar;
// Lanza la ventana de ayuda para Busquedas de codigos si tiene datawindow asignada

isle_campo = sle_valor

IF trim(istr_parametros.s_nom_datawindow)<> "" THEN
  IF Not IsNumber(isle_campo.Text) THEN
		String ll_clave
		istr_parametros.s_criterio_busqueda = isle_campo.Text
           
		OpenWithParm(w_busquedas,istr_parametros)
		ll_clave = Message.StringParm		// Devuelve el valor que enuentra ...
		if TRIM(ll_clave)="" and TRIM(sle_valor.text)<>"" then
         Return
      END IF
   	
		isle_campo.text = ll_clave
      isle_campo.TriggerEvent(Modified!)	// Mostrara la descripcion
      f_activar_campo(isle_campo)
	END IF
END IF
end on

event ue_recuperar;/*

// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_articulo.text))
criterio[2]   =  trim(sle_articulo.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "articulos_coste_lote"

*/

dw_1.Retrieve(codigo_empresa,sle_articulo.text,sle_valor.Text)

CALL Super::ue_recuperar


end event

event ue_desactiva_claves;call super::ue_desactiva_claves;sle_articulo.enabled    = FALSE

end event

event ue_inserta_fila;call super::ue_inserta_fila;string operacion

dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"articulo",sle_articulo.text)
dw_1.setitem(dw_1.getrow(),"lote",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"version",'1')
select art_ver_operaciones.tipo_operacion
		into :operacion
      from art_ver_operaciones 
   	where ( art_ver_operaciones.empresa = :codigo_empresa ) AND  
      ( art_ver_operaciones.articulo = :sle_articulo.text ) AND  
      ( art_ver_operaciones.version = '1' );
dw_1.setitem(dw_1.getrow(),"operacion",operacion)

end event

on wi_mant_articulos_coste_lote.create
int iCurrent
call super::create
this.st_articulo=create st_articulo
this.st_articulo_des=create st_articulo_des
this.sle_articulo=create sle_articulo
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_articulo
this.Control[iCurrent+2]=this.st_articulo_des
this.Control[iCurrent+3]=this.sle_articulo
this.Control[iCurrent+4]=this.cb_1
end on

on wi_mant_articulos_coste_lote.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_articulo)
destroy(this.st_articulo_des)
destroy(this.sle_articulo)
destroy(this.cb_1)
end on

event ue_activa_claves;call super::ue_activa_claves;sle_articulo.enabled    =TRUE

end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_articulos_coste_lote
integer x = 114
integer y = 476
integer width = 2318
integer height = 1052
string dataobject = "dw_articulos_coste_lote"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_articulos_coste_lote
integer x = 160
integer y = 320
integer width = 343
integer height = 80
string text = "Lote"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_articulos_coste_lote
integer x = 2537
integer y = 640
fontcharset fontcharset = ansi!
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_articulos_coste_lote
integer x = 2537
integer y = 776
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_articulos_coste_lote
integer x = 535
integer y = 316
integer height = 92
integer taborder = 20
fontcharset fontcharset = ansi!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 268435456
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo 	     = "AYUDA SELECCION DE LOTES"
ue_datawindow	  = "dw_ayuda_lotes"
ue_filtro 		  = "articulo =  '"+sle_articulo.text+"' "


/*
IF istr_parametros.i_nargumentos>1 THEN
 	  sle_valor.text=istr_parametros.s_argumentos[1]	
     f_no_nulo(sle_valor)
     sle_valor.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[2]
     f_no_nulo(sle_valor)
     istr_parametros.i_nargumentos=0
	  IF Trim(sle_valor.text)<>"" and Trim(sle_articulo.text)<>"" THEN
        Parent.TriggerEvent("ue_recuperar")
        Return
     END IF
   END IF
   
	f_control()
	
*/	
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_articulos_coste_lote
integer x = 2537
integer y = 912
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_articulos_coste_lote
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_articulos_coste_lote
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_articulos_coste_lote
integer width = 2926
end type

type st_articulo from statictext within wi_mant_articulos_coste_lote
integer x = 160
integer y = 200
integer width = 343
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_articulo_des from statictext within wi_mant_articulos_coste_lote
integer x = 814
integer y = 204
integer width = 1339
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type sle_articulo from u_em_campo within wi_mant_articulos_coste_lote
integer x = 535
integer y = 192
integer height = 92
integer taborder = 10
fontfamily fontfamily = roman!
string facename = "Times New Roman"
end type

event getfocus;call super::getfocus;  ue_titulo         =  "AYUDA SELECCION DE ARTICULOS"
  ue_datawindow     =  "dw_ayuda_articulos"
  ue_filtro         =  ""
  isle_campo        =  This

  sle_valor.Text = ""
        
  IF istr_parametros.i_nargumentos>1 THEN
 	  sle_articulo.text=istr_parametros.s_argumentos[1]	
     f_no_nulo(sle_articulo)
     sle_articulo.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[2]
     f_no_nulo(sle_valor)
     istr_parametros.i_nargumentos=0
	  IF Trim(sle_valor.text)<>"" and Trim(sle_articulo.text)<>"" THEN
        Parent.TriggerEvent("ue_recuperar")
        Return
     END IF
   END IF
   
	f_control()


end event

event modificado;call super::modificado;st_articulo_des.text=f_nombre_articulo(codigo_empresa,sle_articulo.text)
IF Trim(st_articulo_des.text)="" THEN 
 IF Trim(st_articulo_des.text)<>"" Then  f_activar_campo(sle_articulo)
 st_articulo_des.text=""
END IF
end event

type cb_1 from commandbutton within wi_mant_articulos_coste_lote
integer x = 1207
integer y = 316
integer width = 407
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Calcular"
end type

event clicked;boolean fallo
string articulo, lote, ver, tipo_operacion, lineaprod

articulo = sle_articulo.text
lote = sle_valor.text
ver = '1'

select linea
into :lineaprod
from prodpartes_ot
where empresa = :codigo_empresa
and articulo = :articulo
and version = :ver
and lote = :lote;

select art_ver_operaciones.tipo_operacion
into :tipo_operacion
from art_ver_operaciones 
where ( art_ver_operaciones.empresa = :codigo_empresa ) AND  
( art_ver_operaciones.articulo = :articulo ) AND  
( art_ver_operaciones.version = :ver );


fallo = f_actualizar_coste_lote_planificacion(codigo_empresa,articulo,sqlca,lote,ver,tipo_operacion, lineaprod)
	
if fallo = true then 
	
	f_mensaje("Atención","Hubo un error al calcular los costes")
	return
	
end if

messagebox("Éxito", "Al calcular el coste del articulo")

dw_1.Retrieve(codigo_empresa,sle_articulo.text,sle_valor.Text)


end event

