# GENIE Dashboard App Structure

## Dashboard Layout

The GENIE Dashboard uses the `shinydashboard` package to create a professional-looking interface with the following structure:

### Header
- **Title**: "GENIE Metadata Explorer"
- **Width**: 300px
- Clean, blue-themed header bar

### Sidebar Navigation
The sidebar contains navigation menu items:

1. **Overview** 📊
   - Dashboard icon
   - Summary statistics and key metrics
   
2. **Sample Explorer** 📋
   - Table icon  
   - Interactive data table for browsing samples
   
3. **Cancer Types** 🥧
   - Chart-pie icon
   - Cancer type distribution analysis
   
4. **Mutations** 🧬
   - DNA icon
   - Mutation count distributions
   
5. **About** ℹ️
   - Info-circle icon
   - Application information

### Main Content Areas

#### Overview Tab
- **Value Boxes** (3 across):
  - Total Samples (blue, vial icon)
  - Total Patients (green, user icon) 
  - Cancer Types (yellow, heartbeat icon)

- **Charts** (2 across):
  - Cancer Type Distribution (horizontal bar chart)
  - Age Distribution (histogram)

#### Sample Explorer Tab
- **Data Table**:
  - Interactive filtering
  - Sortable columns
  - Search functionality
  - Pagination (15 rows per page)
  - Columns: sample_id, patient_id, cancer_type, stage, age_at_diagnosis, gender, mutation_count

#### Cancer Types Tab
- **Detailed Analysis** (8/12 width):
  - Stacked bar chart showing cancer types by stage
  - Interactive with plotly
  
- **Statistics Table** (4/12 width):
  - Summary stats per cancer type
  - Samples count, average age, average mutations

#### Mutations Tab
- **Mutation Distribution**:
  - Histogram of mutation counts
  - Interactive plotly chart

#### About Tab
- **Information Panel**:
  - Application version and description
  - Feature list
  - Data source information

## Color Scheme
- **Primary**: #3c8dbc (blue)
- **Success**: #00a65a (green)
- **Warning**: #f39c12 (orange)
- **Danger**: #dd4b39 (red)
- **Info**: #00c0ef (light blue)

## Sample Data Structure
The app includes sample data with 100 records containing:
- 50 unique patients (2 samples each)
- 5 cancer types (Lung, Breast, Colorectal, Prostate, Melanoma)
- 4 stages (I, II, III, IV)
- Age range: 30-80 years
- Gender: Male/Female
- Mutation counts: 1-50

## Responsive Design
- Dashboard adapts to different screen sizes
- Interactive plots scale appropriately
- Data tables include horizontal scrolling for mobile
- Clean, professional appearance with blue skin theme