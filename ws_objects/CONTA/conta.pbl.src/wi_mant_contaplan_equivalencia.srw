$PBExportHeader$wi_mant_contaplan_equivalencia.srw
forward
global type wi_mant_contaplan_equivalencia from wi_mvent_con_empresa
end type
type uo_ejercicio from u_ejercicio within wi_mant_contaplan_equivalencia
end type
type cbx_plan_nuevo from checkbox within wi_mant_contaplan_equivalencia
end type
type uo_barra_contador from u_barra_contador within wi_mant_contaplan_equivalencia
end type
type dw_2 from datawindow within wi_mant_contaplan_equivalencia
end type
end forward

global type wi_mant_contaplan_equivalencia from wi_mvent_con_empresa
integer width = 3557
integer height = 1864
uo_ejercicio uo_ejercicio
cbx_plan_nuevo cbx_plan_nuevo
uo_barra_contador uo_barra_contador
dw_2 dw_2
end type
global wi_mant_contaplan_equivalencia wi_mant_contaplan_equivalencia

type variables

end variables

forward prototypes
public subroutine f_cargar_contaplan (ref datawindow adw_data, string as_empresa, integer ai_ejercicio)
public subroutine f_cargar_pgcn (ref datawindow adw_data)
end prototypes

public subroutine f_cargar_contaplan (ref datawindow adw_data, string as_empresa, integer ai_ejercicio);Long				i,j, ll_cont,ll_fila
String			ls_sql,ls_cuenta_equiv,ls_titulo_equiv,ls_cuenta_vieja
DataStore 		lds_contaplan


ls_sql = "SELECT contaplan.ejercicio, contaplan.empresa,contaplan.cuenta, " + &
			" contaplan.titulo,contaplan.analitica, contaplan.tipocta, " + &
			" contaplan.directos, contaplan.nivel, contaplan.coste " + &
			" FROM   contaplan " +&
				" WHERE contaplan.ejercicio = " + String(ai_ejercicio)  + &
				" AND contaplan.empresa = '" + as_empresa + "'" +&
				" ORDER BY contaplan.ejercicio,contaplan.empresa, contaplan.cuenta"

lds_contaplan = f_cargar_cursor(ls_sql)

f_mensaje_proceso("Procesando",1,100)

ll_cont = lds_contaplan.RowCount()
IF ll_cont > 0 THEN
	
	
	FOR i = 1 TO ll_cont
		j = adw_data.InsertRow(0)
		adw_data.Object.ejercicio[j]     = ai_ejercicio
		adw_data.Object.empresa[j]	      = as_empresa
		adw_data.Object.cuenta_vieja[j]	= lds_contaplan.object.cuenta[i]
		adw_data.Object.titulo_viejo[j]	= lds_contaplan.object.titulo[i]
		adw_data.Object.analitica[j]		= lds_contaplan.object.analitica[i]	
		adw_data.Object.tipocta[j]		   = lds_contaplan.object.tipocta[i]	
		adw_data.Object.directos[j]	   = lds_contaplan.object.directos[i]	
		adw_data.Object.nivel[j]		   = lds_contaplan.object.nivel[i]	
		adw_data.Object.coste[j]		   = lds_contaplan.object.coste[i]
		
		ls_cuenta_vieja = lds_contaplan.object.cuenta[i]
		
		f_mensaje_proceso("Procesando",i,ll_cont)
		/// Añadimos equivalencias
		
		
		SELECT contaplan_tabla_equivalencia.cuenta_equiv, 
			    contaplan_tabla_equivalencia.titulo_equiv
				 into :ls_cuenta_equiv,:ls_titulo_equiv
			 FROM   contaplan_tabla_equivalencia
			 where  contaplan_tabla_equivalencia.cuenta_vieja = :ls_cuenta_vieja
			  using sqlca;
			 
			 if sqlca.sqlcode = 0 then
				
				adw_data.Object.cuenta_equiv[j]	= ls_cuenta_equiv
				adw_data.Object.titulo_equiv[j]  = ls_titulo_equiv
//			else
//				ll_fila = adw_data.insertrow(0)
//				adw_data.Object.ejercicio[ll_fila]     = ai_ejercicio
//				adw_data.Object.empresa[ll_fila]	      = as_empresa
//				adw_data.Object.cuenta[ll_fila]	= lds_contaplan.object.cuenta[i]
//				adw_data.Object.titulo[ll_fila]	= lds_contaplan.object.titulo[i]
//				adw_data.Object.analitica[ll_fila]		= lds_contaplan.object.analitica[i]	
//				adw_data.Object.tipocta[ll_fila]		   = lds_contaplan.object.tipocta[i]	
//				adw_data.Object.directos[ll_fila]	   = lds_contaplan.object.directos[i]	
//				adw_data.Object.nivel[ll_fila]		   = lds_contaplan.object.nivel[i]	
//				adw_data.Object.coste[ll_fila]		   = lds_contaplan.object.coste[i]
		
				
				
			end if
	NEXT
	
	Destroy(lds_contaplan)

	adw_data.SetFocus()
	adw_data.SetRow(1)
	adw_data.SetColumn("cuenta_equiv")
	f_mensaje_proceso("Procesando",100,100)
//	Return ll_cont
ELSE
	Destroy(lds_contaplan)
//	Messagebox("ERROR","No hay materias para los datos indicados !")
//	Return 0
END IF


end subroutine

public subroutine f_cargar_pgcn (ref datawindow adw_data);// Preparar Dw para importar excel.
integer li_opcion
string sel


li_opcion = MessageBox("Proceso de Carga del PGCN desde una hoja de cálculo","Desea cargar PGCN",Question!,YesNo!,2)

if li_opcion = 1 then
	
	DELETE from contaplan_PGCN
	using sqlca;

	
	
//	 adw_data.Reset()
	 
	 // Importar de Excel a Una Dw
	OLEObject excel 
	Integer li_RetValue, li_rtn 
	Boolean lb_sheet_rtn
	Boolean lb_exist , lb_exist_base
	Long ll_cnt
	Long        li_rc , ll_rc
	String      ls_path_excel
	String       ls_new_excel
	
	
	// Genero  Nuevo
	ls_new_excel  = "C:\contaplan_pgcn_new.xls"
	ls_path_excel  ="C:\contaplan_pgcn.xls"
	
	 lb_exist_base = FileExists(ls_path_excel)
	
	  If lb_exist_base = False Then
	MessageBox("Importación","" + "No se encuentra la tabla de equivalencias : " +  ls_path_excel)
	else
	
	// Chek de Existencia para Borrarlo
	lb_exist = FileExists(ls_new_excel)
	IF lb_exist Then FileDelete(ls_new_excel)
	
//	 st_1.Text ="Creando Conecxión a Excel"  
	 
	// Crear Objeto
	Excel = create OLEObject 
	
	//Conectar a Excel
	li_rtn = excel.ConnectToNewObject("excel.application") 
	IF li_rtn <> 0 THEN 
			MessageBox('Excel error','No puede conectarse a Excel') 
		DESTROY excel 
	
	 END IF 
	 
	  
	 //Abrir excel
	excel.WorkBooks.Open( ls_path_excel ) 
	excel.Application.Visible = False
	excel.windowstate   = 2  // Estados 1 : Normal, 2 : Minimize, 3 : Maximize 
	//Seleccionar un rango y eliminarlo
//	st_1.Text ="Creando Nuevo Excel"  
	 lb_sheet_rtn = excel.worksheets(1).Activate
		excel.Worksheets(1).Range("A1:E1").Delete
	 excel.application.workbooks(1).saveas(ls_new_excel,-4143) 
	 //Seleccionar todo lo activo y copiarlo al CLip
	 excel.ActiveCell.CurrentRegion.Select()  
	 excel.Selection.Copy()
//	 st_1.Text ="Importando Excel"  
	 //Importar desde el Clipboard
	 ll_rc = adw_data.ImportClipBoard (1) 
	 ClipBoard('') 
	 excel.Application.Quit
	 excel.disconnectobject() 
	 DESTROY excel 
	end if
	
	
	adw_data.setsort("cuenta A")
	adw_data.sort()
	
	adw_data.AcceptText()
	
	IF adw_data.Update() = 1 THEN 
		COMMIT using sqlca;
	ELSE		
		ROLLBACK using sqlca;
	END IF
	
else
	/// Cargamos en la adw_data
	/// si no existe
	sel = ' select * from contaplan_pgcn '
	datastore ads_datos
	ads_datos = f_cargar_cursor(sel)
	ads_datos.rowscopy(1,ads_datos.rowcount(),Primary!, adw_data, 1, Primary!)

end if	


end subroutine

event open;call super::open;if not (f_control_usuario_contabilidad(nombre_usuario)) then
	messagebox ('Violacion de seguridad','No se tiene acceso a la zona restringida')
	close(this)
else

   istr_parametros.s_titulo_ventana  = "Mantenimiento de cuentas de equivalencia "
	istr_parametros.s_listado         = "report_contaorigen"
   This.title = istr_parametros.s_titulo_ventana
	tipo_mantenimiento = "C"
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
        dw_1.Retrieve(sle_valor.Text,Dec(uo_ejercicio.em_ejercicio.text))
      END IF
   END IF

//	f_mascara_columna(dw_1,"asientoinicial","###,##0")
	
end if
//cb_borrar.enabled    =  true
//cb_insertar.enabled  =  true

dw_2.settransobject( sqlca)
end event

event ue_inserta_fila;call super::ue_inserta_fila;// dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
// dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)

end event

event ue_recuperar;

// Valores Para Funcion de bloqueo
Dec ejer
ejer          = Dec(uo_ejercicio.em_ejercicio.text)


titulo        =  This.title
longitud      =  len(trim(string(ejer)))
criterio[2]   =  trim(string(ejer))+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[1]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "contaplan_equivalencia"



dw_1.Retrieve(dec(sle_valor.Text),ejer)

if dw_1.rowcount( )<= 0 then
	/// recuperar cuenta contable
	/// añadirselo a la de equivalencia
	dw_1.setredraw(false)
	 // Función que nos carga el plan contable de la empresa
	 // que se seleccione y las equivalencias correspondientes
	 f_cargar_contaplan(dw_1,sle_valor.text,ejer)
	
	dw_1.setredraw(true)
end if

CALL Super::ue_recuperar
end event

event ue_activa_claves;call super::ue_activa_claves;//pb_calculadora.visible = TRUE
end event

on wi_mant_contaplan_equivalencia.create
int iCurrent
call super::create
this.uo_ejercicio=create uo_ejercicio
this.cbx_plan_nuevo=create cbx_plan_nuevo
this.uo_barra_contador=create uo_barra_contador
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_ejercicio
this.Control[iCurrent+2]=this.cbx_plan_nuevo
this.Control[iCurrent+3]=this.uo_barra_contador
this.Control[iCurrent+4]=this.dw_2
end on

on wi_mant_contaplan_equivalencia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_ejercicio)
destroy(this.cbx_plan_nuevo)
destroy(this.uo_barra_contador)
destroy(this.dw_2)
end on

event ue_desactiva_claves;call super::ue_desactiva_claves;//pb_calculadora.visible = FALSE
end event

event activate;call super::activate;wi_mant_contaplan_equivalencia = ventanas_activas[id_ventana_activa].ventana
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_contaplan_equivalencia
integer y = 288
integer width = 3365
integer height = 1280
string dataobject = "dw_contaplan_equivalencia"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::sqlpreview;call super::sqlpreview;//messagebox("AL",sqlsyntax)
end event

event dw_1::clicked;
This.Setfocus()
dw_1.AcceptText()
IF trim(sle_valor.text)=""  Or   f_tipo_mantenimiento(tipo_mantenimiento,isle_campo.text) THEN
	dw_1.enabled=FALSE
	dw_1.reset()
	cb_borrar.enabled     = FALSE
	f_activar_campo(sle_valor)
ELSE	
	IF cb_insertar.enabled = FALSE THEN

	//	Parent.TriggerEvent("ue_recuperar")		
		
		IF insercion = "S" and Not f_control_altas_usuario(codigo_empresa,nombre_usuario) Then
			return
		END IF
		
		IF insercion="N" THEN
			// Control permisos modificaciones por usuarios
			IF Not f_control_modificaciones_usuario(codigo_empresa,nombre_usuario) Then
				f_mensaje("Control de permisos por usuario","Usted No tiene permiso de Modificaciones")
				f_grabar_incidencia("Control de modificaciones","El usuario  "+ nombre_usuario + " Control de Modificaciones (Permiso denegado")
				dw_1.enabled          =  FALSE
				cb_insertar.enabled   =  FALSE
				Parent.TriggerEvent("ue_activa_claves")
				return
			END IF
			IF NOT f_bloquear(tabla,seleccion,titulo) THEN
				COMMIT Using sqlca; // problema concurrencia
				cb_insertar.enabled   = TRUE
				cb_borrar.enabled     = FALSE
				Parent.TriggerEvent("ue_desactiva_claves")
				control_tabulador.enabled = FALSE
			ELSE
				dw_1.enabled          =  FALSE
				cb_insertar.enabled   =  FALSE
				Parent.TriggerEvent("ue_activa_claves")
			END IF
		END IF
	END IF
END IF

end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_contaplan_equivalencia
integer x = 50
integer width = 283
string text = "Empresa:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_contaplan_equivalencia
integer x = 1573
integer y = 192
end type

event cb_insertar::clicked;call super::clicked;/// Generamos nuevo plan contable
string ls_empresa,ls_cuenta,ls_titulo,ls_analitica,ls_tipocta,cadena
string ls_directos,ls_coste
string ls_cuenta_vieja,cuenta_nivel_ant ,cuenta_nivel_sup,ls_cuenta_equiv,ls_titulo_viejo,ls_titulo_equiv
if cbx_plan_nuevo.checked then
	
	///Borramos plan contable nuevo
	Dec ejer,lc_nivel,lc_nivel_ant,lc_nivel_sup
	integer li_opcion,l
	long ll_fila,j,i,ll_cont
	ejer          = Dec(uo_ejercicio.em_ejercicio.text) + 1
	
	li_opcion = MessageBox("Proceso de Generación PGCN","Desea volver a generar PGCN",Question!,YesNo!,2)
	
	if li_opcion = 1 then
	
//		DELETE from contaplan
//		where empresa = :codigo_empresa
//		and ejercicio = :ejer
//		using sqlca;
		
		
		
		/// Cargamos tabla execl del Nuevo PGCN
			f_cargar_PGCN(dw_2)
		// generamos nuevo plan de cuentas
		// 1º Cargamos PGCN
		// 2º Añadimos al nuevo plan 
		// las cuentas de equivalencias

	end if
	
	
		/// Añadimos cuentas contaplan_equivalencia
		// y las subcuentas del plan contable antiguo

		f_mensaje_proceso("Procesando",1,100)

		ll_fila = dw_1.rowcount( )
		
		FOR i = 1 TO ll_fila
		
		
			/// Añadimos equivalencias
			ls_cuenta_equiv = dw_1.object.cuenta_equiv[i]
			ls_cuenta_vieja = dw_1.object.cuenta_vieja[i]
			ls_titulo_equiv = dw_1.object.titulo_equiv[i]
			ls_titulo_viejo = dw_1.object.titulo_viejo[i]
			ls_analitica = dw_1.object.analitica[i]
			ls_empresa = dw_1.object.empresa[i]
			ls_tipocta = dw_1.object.tipocta[i]
			ls_directos = dw_1.object.directos[i]
			lc_nivel= dw_1.object.nivel[i]
			ls_coste = dw_1.object.coste[i]
			
			f_mensaje_proceso("Procesando PGCN",i,ll_fila)
		
			
		if not f_nulo_blanco(ls_cuenta_equiv) and &
			trim(ls_cuenta_equiv) <> "D" then
		
		
			
			
					SELECT contaplan.cuenta,contaplan.titulo 
					 into :ls_cuenta,:ls_titulo
					 FROM   contaplan 
					 WHERE  contaplan.cuenta = :ls_cuenta_equiv
					 and    contaplan.empresa = :ls_empresa
					 and    contaplan.ejercicio = :ejer
					using sqlca;
					
					if sqlca.sqlcode = 0 then /// existe
						if not f_nulo_blanco(ls_titulo_equiv) then
							ls_titulo = ls_titulo_equiv
						else
							ls_titulo = ls_titulo_viejo 
						end if						
//						INSERT INTO contaplan
//							( ejercicio,empresa,cuenta,titulo,analitica,tipocta,directos,nivel,coste)
//						  VALUES ( :ejer, :ls_empresa,:ls_cuenta_equiv,:ls_titulo, 
//										:ls_analitica,:ls_tipocta,:ls_directos,:lc_nivel,
//									  :ls_coste)   
//						  USING sqlca;
							update contaplan
							set titulo = :ls_titulo
							where empresa = :ls_empresa
							and ejercicio = :ejer
							and cuenta = :ls_cuenta_equiv
							using sqlca;
//						end if
					else
						
						if sqlca.sqlcode = 100 then  // no existe cuenta
						//Insertamos el registro en la BD Destino.
						
						if not f_nulo_blanco(ls_titulo_equiv) then
							ls_titulo = ls_titulo_equiv
						else
							ls_titulo = ls_titulo_viejo 
						end if
						lc_nivel= f_controlar_digitos(codigo_empresa,ejer,ls_cuenta_equiv)
						
						INSERT INTO contaplan
							( ejercicio,empresa,cuenta,titulo,analitica,tipocta,directos,nivel,coste)
						  VALUES ( :ejer, :ls_empresa,:ls_cuenta_equiv,:ls_titulo, 
										:ls_analitica,:ls_tipocta,:ls_directos,:lc_nivel,
									  :ls_coste)   
						  USING sqlca;
							
							
						end if
						
					end if
				else
					/// No hay cuenta equiv
					/// vemos si ha cambiado el titulo
					SELECT contaplan.cuenta,contaplan.titulo 
					 into :ls_cuenta,:ls_titulo
					 FROM   contaplan
					 WHERE  contaplan.cuenta = :ls_cuenta_vieja
					 and    contaplan.empresa = :ls_empresa
					 and    contaplan.ejercicio = :ejer
					using sqlca;
//					
//					
					if sqlca.sqlcode = 0 then
						if not f_nulo_blanco(ls_titulo_equiv) then
//						
							update contaplan
							set titulo = :ls_titulo_equiv
							where empresa = :ls_empresa
							and ejercicio = :ejer
							and cuenta = :ls_cuenta_vieja
							using sqlca;
						end if
					end if

//						lc_nivel= f_controlar_digitos(codigo_empresa,ejer,ls_cuenta)	
//														
//						INSERT INTO contaplan
//							( ejercicio,empresa,cuenta,titulo,analitica,tipocta,directos,nivel,coste)
//						  VALUES ( :ejer, :ls_empresa,:ls_cuenta_vieja,:ls_titulo, 
//										:ls_analitica,:ls_tipocta,:ls_directos,:lc_nivel,
//									  :ls_coste)   
//						  USING sqlca;
////							update contaplan
////							set titulo = :ls_titulo_equiv
////							where empresa = :codigo_empresa
////							and ejercicio = :ejer
////							and cuenta = :ls_cuenta
////							using sqlca;
//						end if
//					else
//						
//						if sqlca.sqlcode = 100 then  // no existe cuenta
//						//Insertamos el registro en la BD Destino.
//						
//						if not f_nulo_blanco(ls_titulo_equiv) then
//							ls_titulo = ls_titulo_equiv
//						else
//							ls_titulo = ls_titulo_viejo
//						end if
//						lc_nivel= f_controlar_digitos(codigo_empresa,ejer,ls_cuenta_vieja)
//						
//						INSERT INTO contaplan
//							( ejercicio,empresa,cuenta,titulo,analitica,tipocta,directos,nivel,coste)
//						  VALUES ( :ejer, :ls_empresa,:ls_cuenta_vieja,:ls_titulo, 
//										:ls_analitica,:ls_tipocta,:ls_directos,:lc_nivel,
//									  :ls_coste)   
//						  USING sqlca;
//							
//							
//						end if
//						
//					end if
					
			
			end if
		
		next
		
		
	
	f_mensaje_proceso("Procesando",100,100)
//	

/// Recorreme el pgcn y no existe grabar el el nuevo plan

		
		ll_fila = dw_2.rowcount( )
		
		if ll_fila > 0 then
			f_mensaje_proceso("Procesando",1,100)

		
			FOR i = 1 TO ll_fila
				
					f_mensaje_proceso("Procesando PGCN",i,ll_fila)
					
					ls_cuenta = dw_2.object.cuenta[i]
					ls_titulo = dw_2.object.titulo[i]
					
					SELECT contaplan.cuenta 
						into :ls_cuenta
						FROM   contaplan
						WHERE  contaplan.cuenta = :ls_cuenta
						and empresa = :ls_empresa
						and ejercicio = :ejer
						using sqlca;
						
						if sqlca.sqlcode = 100 then  // No existe
							if left(trim(ls_cuenta),1) = "6" or left(trim(ls_cuenta),1)= "7" then
								ls_analitica = "N"
							else
								ls_analitica = "N"
							end if
							// Verificamos nivel anterior
							lc_nivel= f_controlar_digitos(codigo_empresa,ejer,ls_cuenta)
							lc_nivel_ant = lc_nivel - 1
							if lc_nivel_ant <> 0 then
								cuenta_nivel_ant = Mid(ls_cuenta,1,lc_nivel_ant)
							
								select tipocta,directos into :ls_tipocta,:ls_directos
								from contaplan 
								WHERE  contaplan.cuenta = :cuenta_nivel_ant
								and    contaplan.empresa = :codigo_empresa
								and    contaplan.ejercicio = :ejer
								using sqlca;
							
								if sqlca.sqlcode = 100 then
									ls_directos = "N"
									if left(trim(ls_cuenta),1) = "8" then
										ls_tipocta = "8"
									end if
									if left(trim(ls_cuenta),1)= "9" then
										ls_tipocta = "9"
									end if
									// Insertamos nivel inferior
									INSERT INTO contaplan
										( ejercicio,empresa,cuenta,titulo,analitica,tipocta,directos,nivel,coste)
									VALUES ( :ejer, :ls_empresa,:cuenta_nivel_ant,:ls_titulo, 
											:ls_analitica,:ls_tipocta,:ls_directos,:lc_nivel,
										  :ls_coste)   
										USING sqlca;
									
								end if
								/// insertamos cuenta encontrada en el
								/// plan general contable y
								/// no esta en el 2008
								INSERT INTO contaplan
								( ejercicio,empresa,cuenta,titulo,analitica,tipocta,directos,nivel,coste)
								VALUES ( :ejer, :ls_empresa,:ls_cuenta,:ls_titulo, 
											:ls_analitica,:ls_tipocta,:ls_directos,:lc_nivel,
										  :ls_coste)   
								USING sqlca;
						  
							  /// Insertamos nivel superior 4 digitos
							  /// si no existe a nivel de 4 digitos
								lc_nivel= f_controlar_digitos(codigo_empresa,ejer,ls_cuenta)
								lc_nivel_sup = lc_nivel + 1
								cuenta_nivel_sup = Mid(ls_cuenta,1,lc_nivel_sup)
								l = len(trim(ls_cuenta))
								cadena = trim(ls_cuenta)

								IF l < 4 THEN 
									cadena = cadena + fill("0",4 - l)
									ls_cuenta = cadena
								end if
								/// leemos si existe el nivel 
							  SELECT contaplan.cuenta 
								into :ls_cuenta
								FROM   contaplan
								WHERE  contaplan.cuenta = :ls_cuenta
								and empresa = :ls_empresa

								and ejercicio = :ejer
								using sqlca;
						  
						   	if sqlca.sqlcode = 100 then // no existe
									lc_nivel= f_controlar_digitos(codigo_empresa,ejer,ls_cuenta)
							
									INSERT INTO contaplan
										( ejercicio,empresa,cuenta,titulo,analitica,tipocta,directos,nivel,coste)
									  VALUES ( :ejer, :ls_empresa,:ls_cuenta,:ls_titulo, 
													:ls_analitica,:ls_tipocta,:ls_directos,:lc_nivel ,
												  :ls_coste)   
									  USING sqlca;
							
								end if
								
								
								 /// Insertamos nivel superior 6 digitos
							  /// si no existe a nivel de 6 digitos
								lc_nivel= f_controlar_digitos(codigo_empresa,ejer,ls_cuenta)
								lc_nivel_sup = lc_nivel + 1
								cuenta_nivel_sup = Mid(ls_cuenta,1,lc_nivel_sup)
								l = len(trim(ls_cuenta))
								cadena = trim(ls_cuenta)

								IF l < 6 THEN 
									cadena = cadena + fill("0",6 - l)
									ls_cuenta = cadena
								end if
								/// leemos si existe el nivel 
							  SELECT contaplan.cuenta 
								into :ls_cuenta
								FROM   contaplan
								WHERE  contaplan.cuenta = :ls_cuenta
								and empresa = :ls_empresa
								and ejercicio = :ejer
								using sqlca;
						  
						   	if sqlca.sqlcode = 100 then // no existe
									lc_nivel= f_controlar_digitos(codigo_empresa,ejer,ls_cuenta)
							
									INSERT INTO contaplan
										( ejercicio,empresa,cuenta,titulo,analitica,tipocta,directos,nivel,coste)
									  VALUES ( :ejer, :ls_empresa,:ls_cuenta,:ls_titulo, 
													:ls_analitica,:ls_tipocta,:ls_directos,:lc_nivel ,
												  :ls_coste)   
									  USING sqlca;
							
								end if
								
							end if // <>  lc_nivel_ant
								
							else
//								Existe la cuenta pero 
//								verificamos nivel superior 4 digitos
//								para darlo de alta
								lc_nivel= f_controlar_digitos(codigo_empresa,ejer,ls_cuenta)
								l = len(trim(ls_cuenta))
								cadena = trim(ls_cuenta)
								
								IF l < 4 THEN 
								cadena = cadena + fill("0",4 - l)
								ls_cuenta = cadena
								end if

								SELECT contaplan.cuenta 
								 into :ls_cuenta
								FROM   contaplan
								WHERE  contaplan.cuenta = :ls_cuenta
								and empresa = :ls_empresa
								and ejercicio = :ejer
								using sqlca;
						  
								if sqlca.sqlcode = 100 then// no existe
								
									lc_nivel= f_controlar_digitos(codigo_empresa,ejer,ls_cuenta)
									INSERT INTO contaplan
								( ejercicio,empresa,cuenta,titulo,analitica,tipocta,directos,nivel,coste)
								VALUES ( :ejer, :ls_empresa,:ls_cuenta,:ls_titulo, 
											:ls_analitica,:ls_tipocta,:ls_directos,:lc_nivel ,
										  :ls_coste)   
								USING sqlca;
														
							end if //  4 digitos
							
							 /// Insertamos nivel superior 6 digitos
						  /// si no existe a nivel de 6digitos
							lc_nivel= f_controlar_digitos(codigo_empresa,ejer,ls_cuenta)
							lc_nivel_sup = lc_nivel + 1
							cuenta_nivel_sup = Mid(ls_cuenta,1,lc_nivel_sup)
							l = len(trim(ls_cuenta))
							cadena = trim(ls_cuenta)

							IF l < 6 THEN 
								cadena = cadena + fill("0",6 - l)
								ls_cuenta = cadena
							end if
							/// leemos si existe el nivel 
						  SELECT contaplan.cuenta 
							into :ls_cuenta
							FROM   contaplan
							WHERE  contaplan.cuenta = :ls_cuenta
							and empresa = :ls_empresa
							and ejercicio = :ejer
							using sqlca;
							if sqlca.sqlcode = 100 then // no existe
									lc_nivel= f_controlar_digitos(codigo_empresa,ejer,ls_cuenta)
							
									INSERT INTO contaplan
										( ejercicio,empresa,cuenta,titulo,analitica,tipocta,directos,nivel,coste)
									  VALUES ( :ejer, :ls_empresa,:ls_cuenta,:ls_titulo, 
													:ls_analitica,:ls_tipocta,:ls_directos,:lc_nivel ,
												  :ls_coste)   
									  USING sqlca;
							
							end if
							
							
								  
						end if
						
	//				ls_analitica = dw_1.object.analitica[i]
	//				ls_empresa = dw_1.object.empresa[i]
	//				ls_tipocta = dw_1.object.tipocta[i]
	//				ls_directos = dw_1.object.directos[i]
	//				lc_nivel= dw_1.object.nivel[i]
	//				ls_coste = dw_1.object.coste[i]
			next
			f_mensaje_proceso("Procesando",100,100)
		end if

//	
//	
//	
//	
//	
//	
//	
//	
end if

end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_contaplan_equivalencia
integer x = 2048
integer y = 192
end type

event cb_borrar::clicked;integer li_opcion
dec ejer

//ejer = 
li_opcion = MessageBox("Proceso de Borrado cuentas equivalentes", &
		"Desea borrar registro", &
		Question!, YesNo!,2)
	IF li_opcion=1 THEN
//		
		ejer          = Dec(uo_ejercicio.em_ejercicio.text) 
		
		delete from contaplan_equivalencia
		where empresa = :codigo_empresa
		and   ejercicio = :ejer
		using sqlca;
		
		dw_1.reset()
		sle_valor.text = ""
		f_activar_campo(sle_valor)
	end if
end event

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_contaplan_equivalencia
integer x = 352
integer y = 204
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_empresa"
ue_titulo      = "AYUDA SELECCION DE EMPRESAS CONTABLES"
ue_filtro      =""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_contaplan_equivalencia
integer x = 2523
integer y = 192
end type

event cb_salir::clicked;IF cb_insertar.enabled=TRUE THEN
         // saldo de proceso de altas
			IF insercion = "S" Then
			 sle_valor.text = ""
          sle_valor.TriggerEvent("modificado")
  		    cb_borrar.enabled  =FALSE
			 dw_1.Reset()
  		   END IF
         insercion= "N"
			Parent.TriggerEvent("ue_desbloquear")
			//Parent.TriggerEvent("ue_recuperar")
         cb_insertar.enabled = FALSE
	     	Parent.TriggerEvent("ue_activa_claves")
        
         f_activar_campo(sle_valor)
ELSE
	     Call Super::Clicked
END IF


 
end event

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_contaplan_equivalencia
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_contaplan_equivalencia
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_contaplan_equivalencia
integer width = 2834
end type

type uo_ejercicio from u_ejercicio within wi_mant_contaplan_equivalencia
integer x = 2853
integer y = 64
integer width = 622
integer height = 320
integer taborder = 40
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type cbx_plan_nuevo from checkbox within wi_mant_contaplan_equivalencia
integer x = 658
integer y = 192
integer width = 549
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Generar PGCN"
end type

event clicked;if this.checked then
	
	cb_insertar.enabled = true
	
else
	cb_insertar.enabled = false
end if
end event

type uo_barra_contador from u_barra_contador within wi_mant_contaplan_equivalencia
boolean visible = false
integer x = 1280
integer y = 736
integer taborder = 50
boolean bringtotop = true
end type

on uo_barra_contador.destroy
call u_barra_contador::destroy
end on

type dw_2 from datawindow within wi_mant_contaplan_equivalencia
boolean visible = false
integer x = 37
integer y = 96
integer width = 475
integer height = 192
integer taborder = 60
string dataobject = "dw_contaplan_pgcn"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

