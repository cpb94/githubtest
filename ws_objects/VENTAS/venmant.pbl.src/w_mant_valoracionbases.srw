$PBExportHeader$w_mant_valoracionbases.srw
forward
global type w_mant_valoracionbases from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_valoracionbases
end type
type cb_1 from commandbutton within w_mant_valoracionbases
end type
type cb_2 from commandbutton within w_mant_valoracionbases
end type
end forward

global type w_mant_valoracionbases from wi_mvent_con_empresa
integer width = 2085
integer height = 1340
pb_calculadora pb_calculadora
cb_1 cb_1
cb_2 cb_2
end type
global w_mant_valoracionbases w_mant_valoracionbases

on w_mant_valoracionbases.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_mant_valoracionbases.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;/*
istr_parametros.s_titulo_ventana = "Mantenimiento Valoración de Bases"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)
f_activar_campo(sle_valor)
*/


istr_parametros.s_titulo_ventana  = "Mantenimiento Valoración de Bases"
This.title = istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)
f_activar_campo(sle_valor)

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text=istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
		dw_1.Retrieve(codigo_empresa,sle_valor.Text)
	END IF
END IF

end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = FALSE
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)

end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "valoracionbases"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar





end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_valoracionbases
integer x = 32
integer y = 324
integer width = 1915
integer height = 616
string dataobject = "dw_mant_valoracionbases"
end type

event dw_1::rbuttondown;bus_filtro = ""
valor_empresa = TRUE	
bus_titulo = ""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE ""
END CHOOSE

CALL Super::rbuttondown
end event

event dw_1::key;bus_filtro = ""
valor_empresa = TRUE	
bus_titulo = ""
bus_campo = This.GetColumnName()
CHOOSE CASE bus_campo
	CASE ""
END CHOOSE

CALL Super::key
end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_valoracionbases
integer x = 46
integer y = 192
integer width = 320
string text = "Codigo:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_valoracionbases
integer x = 805
integer y = 184
integer width = 375
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_valoracionbases
integer x = 1189
integer y = 184
integer width = 375
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_valoracionbases
integer x = 347
integer y = 188
integer width = 233
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo   = "AYUDA DE VALORACIÓN DE BASES"
ue_datawindow = "dw_ayuda_valoracionbases"
ue_filtro = ""

valor_empresa = TRUE


end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_valoracionbases
integer x = 1573
integer y = 184
integer width = 375
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_valoracionbases
integer taborder = 40
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_valoracionbases
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_valoracionbases
integer x = 27
integer width = 1961
end type

type pb_calculadora from u_calculadora within w_mant_valoracionbases
integer x = 590
integer y = 180
integer width = 114
integer height = 100
integer taborder = 20
boolean originalsize = false
end type

event clicked;Integer registros

IF cb_insertar.enabled THEN Return

Select count(*) 
Into   :registros
From   valoracionbases
Where  valoracionbases.empresa = :codigo_empresa;
IF registros = 0 THEN
	sle_valor.text="1"
ELSE
	Select max(convert(int,valoracionbases.codigo)+1)
	Into   :sle_valor.text
	From   valoracionbases
	Where  valoracionbases.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end event

type cb_1 from commandbutton within w_mant_valoracionbases
integer x = 55
integer y = 988
integer width = 997
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Regenerar Tarifa por Completo"
end type

event clicked;datastore dw_proceso
dec cont, registros, total, total_tarifas
string sel, v_articulo, v_fecha_tar_activa, v_fecha_alta, articulo_calidad, v_formato, v_familia, v_usuario
dec{2} v_precio, v_ancho, v_largo, v_precio_base_c_r, v_valor_base_c_r, v_precio_base_l
dec{2} v_valor_base_l, v_precio_bizcocho, v_valor_bizcocho, v_valor_acabado, v_precio_acabado
string v_g2, v_g3, des_articulo, v_moneda
int bien
////////////////////////////////////////////// Esto hay que quitarlo para que la funcione el script //////////////////////////////////////////////
	MessageBox("Atención", " Esta tarea sólo puede ejecutarla el administrador ", StopSign!  ) 
	return
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if MessageBox("Atención", "Se va a regenerar la tarifa de valoración de stock por completo.  ¿Desea continuar?.", Question!, YesNo!, 2) = 1 then
	select activa 
	into :v_fecha_tar_activa
	from ventarifas
	where codigo = "5"
	and empresa = :codigo_empresa;

	delete from venlintarifas
	where empresa = :codigo_empresa
	and tarifa = '5';
	
	v_fecha_alta = String(Today(), "dd/mm/yy hh:mm:ss")
	
	sel = "select codigo, descripcion, formato, familia, usuario "+&
			"from articulos "+&
			"where empresa = "+codigo_empresa+";"

//	dw_proceso = f_cargar_cursor(sel)		
	f_Cargar_cursor_nuevo(sel, dw_proceso)
	
	registros = dw_proceso.rowcount()
	
	select precio_base_c_r, valor_base_c_r, precio_base_l, valor_base_l, precio_bizcocho, valor_bizcocho, valor_acabado
	into :v_precio_base_c_r, :v_valor_base_c_r, :v_precio_base_l, :v_valor_base_l, :v_precio_bizcocho, 
		  :v_valor_bizcocho, :v_valor_acabado
	from valoracionbases
	where empresa = :codigo_empresa
	and codigo = "1";
	
	IF registros > 0 Then
		FOR cont = 1 To registros
			v_articulo = dw_proceso.object.codigo[cont]

//			select count(*)
//			into :Total_tarifas
//			from venlintarifas
//			where empresa = :codigo_empresa
//			and articulo = :v_articulo
//			and tarifa = "5";

//			if total_tarifas = 0 then
			articulo_calidad = v_articulo + "01"
			v_formato = dw_proceso.object.formato[cont] 
			v_familia = dw_proceso.object.familia[cont] 
			v_usuario = dw_proceso.object.usuario[cont] 
			
			select ancho, largo
			into :v_ancho, :v_largo
			from formatos
			where empresa = :codigo_empresa
			and   codigo = :v_formato;
			
			select g2, g3
			into :v_g2, :v_g3
			from art_codestadistico
			where empresa = :codigo_empresa
			and codigo = :v_articulo;
			
			des_articulo = dw_proceso.object.descripcion[cont] 
				
			if (v_g2 = "B") and ((v_g3 = "C") or (v_g3 = "R")) then
				v_precio = (v_ancho / 100) * (v_largo / 100) * (v_precio_base_c_r * (1 - v_valor_base_c_r/100))
			elseif (v_g2 = "B") and ((v_g3 = "L") or (v_g3 = "P")) then
				v_precio = (v_ancho / 100) * (v_largo / 100) * (v_precio_base_l * (1 - v_valor_base_l/100))
			elseif (v_g2 = "Z") then
				v_precio = (v_ancho / 100) * (v_largo / 100) * (v_precio_bizcocho * (1 - v_valor_bizcocho/100))
			else
				v_precio_Acabado = 0
				select venlintarifas.precio, ventarifas.moneda
				into   :v_precio_acabado, :v_moneda
				from venlintarifas, ventarifas
				where venlintarifas.empresa = :codigo_empresa
				and ventarifas.empresa = :codigo_empresa
				and venlintarifas.articulo = :v_articulo
				and venlintarifas.tarifa = ventarifas.codigo;

				if v_moneda <> "" then
					v_precio_acabado = v_precio_acabado / f_cambio_moneda(v_moneda)
				end if
				
				if v_precio_acabado = 0 then
					v_precio = 0
				else
					v_precio = v_precio_acabado * (1 - v_valor_acabado/100)
				end if
			end if
										
				insert into venlintarifas
					(empresa, tarifa, fecha, articulo, calidad, precio, falta, montajeartcal, familia, formato, 
					activo, listar, usuario, descripcion, excepcion, tipo_linea)
					values (:codigo_empresa, "5", :v_fecha_tar_activa, :v_articulo, "1", :v_precio, :v_fecha_alta,
							:articulo_calidad, :v_familia, :v_formato, "S", "S", :v_usuario, :des_articulo, "N", "2");
							
				if SQLCA.SQLCode <> 0 then bien = 1						
	//		end if
			f_mensaje_proceso ("Generando Tarifas: ",cont, registros)
		NEXT
	
		IF bien = 1 THEN
			rollback;
			MessageBox("Problemas en la transaccion", &
						  "No se pueden grabar las tarifas que no exsitían", &
						  Exclamation!,Ok!,2)
		ELSE
			commit;
		END IF
	END IF
	
	destroy dw_proceso
	
	messagebox ("Información", "El Proceso Ha Finalizado")

end if

end event

type cb_2 from commandbutton within w_mant_valoracionbases
integer x = 1211
integer y = 992
integer width = 594
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar Tarifa "
end type

event clicked;datastore dw_proceso
dec cont, registros, total, total_tarifas
string sel, v_articulo, v_fecha_tar_activa, v_fecha_alta, articulo_calidad, v_formato, v_familia, v_usuario
dec{2} v_precio, v_ancho, v_largo, v_precio_base_c_r, v_valor_base_c_r, v_precio_base_l
dec{2} v_valor_base_l, v_precio_bizcocho, v_valor_bizcocho, v_valor_acabado, v_precio_acabado
string v_g2, v_g3, des_articulo, v_moneda
int bien

if MessageBox("Atención", "Se va a generar la tarifa de valoración de stock de aquelos artículos que no la tienen.  ¿Desea continuar?.", Question!, YesNo!, 2) = 1 then
	select activa 
	into :v_fecha_tar_activa
	from ventarifas
	where codigo = "5"
	and empresa = :codigo_empresa;

//	delete from venlintarifas
//	where empresa = :codigo_empresa
//	and tarifa = '5';
	
	v_fecha_alta = String(Today(), "dd/mm/yy hh:mm:ss")
		
	sel = "select codigo, descripcion, formato, familia, usuario "+&
			"from articulos "+&
			"where codigo not in (select articulo from venlintarifas where empresa = '1' and tarifa = '5') "+&
			" and uso <> '2' " +&
			"and empresa = "+codigo_empresa+";"

//	dw_proceso = f_cargar_cursor(sel)		
	f_Cargar_cursor_nuevo(sel, dw_proceso)
	
	registros = dw_proceso.rowcount()
	
	select precio_base_c_r, valor_base_c_r, precio_base_l, valor_base_l, precio_bizcocho, valor_bizcocho, valor_acabado
	into :v_precio_base_c_r, :v_valor_base_c_r, :v_precio_base_l, :v_valor_base_l, :v_precio_bizcocho, 
		  :v_valor_bizcocho, :v_valor_acabado
	from valoracionbases
	where empresa = :codigo_empresa
	and codigo = "1";
	
	IF registros > 0 Then
		FOR cont = 1 To registros
			v_articulo = dw_proceso.object.codigo[cont]

			articulo_calidad = v_articulo + "01"
			v_formato = dw_proceso.object.formato[cont] 
			v_familia = dw_proceso.object.familia[cont] 
			v_usuario = dw_proceso.object.usuario[cont] 
			
			select ancho, largo
			into :v_ancho, :v_largo
			from formatos
			where empresa = :codigo_empresa
			and   codigo = :v_formato;
			
			select g2, g3
			into :v_g2, :v_g3
			from art_codestadistico
			where empresa = :codigo_empresa
			and codigo = :v_articulo;
			
			des_articulo = dw_proceso.object.descripcion[cont] 
				
			if (v_g2 = "B") and ((v_g3 = "C") or (v_g3 = "R")) then
				v_precio = (v_ancho / 100) * (v_largo / 100) * (v_precio_base_c_r * (1 - v_valor_base_c_r/100))
			elseif (v_g2 = "B") and ((v_g3 = "L") or (v_g3 = "P")) then
				v_precio = (v_ancho / 100) * (v_largo / 100) * (v_precio_base_l * (1 - v_valor_base_l/100))
			elseif (v_g2 = "Z") then
				v_precio = (v_ancho / 100) * (v_largo / 100) * (v_precio_bizcocho * (1 - v_valor_bizcocho/100))
			else
				v_precio_Acabado = 0
				select venlintarifas.precio, ventarifas.moneda
				into   :v_precio_acabado, :v_moneda
				from venlintarifas, ventarifas
				where venlintarifas.empresa = :codigo_empresa
				and ventarifas.empresa = :codigo_empresa
				and venlintarifas.articulo = :v_articulo
				and venlintarifas.tarifa = ventarifas.codigo;

				if v_moneda <> "" then
					v_precio_acabado = v_precio_acabado / f_cambio_moneda(v_moneda)
				end if
				
				if v_precio_acabado = 0 then
					v_precio = 0
				else
					v_precio = v_precio_acabado * (1 - v_valor_acabado/100)
				end if
			end if
										
				insert into venlintarifas
					(empresa, tarifa, fecha, articulo, calidad, precio, falta, montajeartcal, familia, formato, 
					activo, listar, usuario, descripcion, excepcion, tipo_linea)
					values (:codigo_empresa, "5", :v_fecha_tar_activa, :v_articulo, "1", :v_precio, :v_fecha_alta,
							:articulo_calidad, :v_familia, :v_formato, "S", "S", :v_usuario, :des_articulo, "N", "2");
							
				if SQLCA.SQLCode <> 0 then bien = 1						
	//		end if
			f_mensaje_proceso ("Generando Tarifas: ",cont, registros)
		NEXT
	
		IF bien = 1 THEN
			rollback;
			MessageBox("Problemas en la transaccion", &
						  "No se pueden grabar las tarifas que no exsitían", &
						  Exclamation!,Ok!,2)
		ELSE
			commit;
		END IF
	END IF
	
	destroy dw_proceso
	
	messagebox ("Información", "El Proceso Ha Finalizado")

end if

end event

